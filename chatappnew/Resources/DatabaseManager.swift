//
//  DatabaseManager.swift
//  chatappnew
//
//  Created by NguyenPhuongkhoa on 13/07/2023.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager
{
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    static func safeEmail(emailAdress: String) -> String
    {
        var safeEmail = emailAdress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
}
extension DatabaseManager
{
    public func userExist(with email: String, completion: @escaping ((Bool) -> Void))
    {
        
        //Replacing special character
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String  != nil else
            {
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    //Insert User
    public func insertUser(with user: chatappUser, completion: @escaping (Bool) -> Void)
    {
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "phone_numer": user.phoneNumber,
            "Gender": user.Gender
        ], withCompletionBlock: { error, _ in
            guard error == nil else
            {
                print("failed ot write ti database")
                completion(false)
                return
            }
            
            self.database.child("user").observeSingleEvent(of: .value, with: { snapshot in
                if var userCollection = snapshot.value as? [[String: String]]{
                    //append to user dictionary
                    let newElement = [
                        "name": user.firstName + "/" + user.emailAddress,
                        "email": user.safeEmail
                    ]
                    userCollection.append(newElement)

                    self.database.child("users").setValue(userCollection, withCompletionBlock: {
                        error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }
                        completion(true)

                    })
                }
                else {
                    //create that array
                    let newCollection: [[String: String]] = [
                       [
                        "name": user.firstName + "/" + user.emailAddress,
                        "email": user.safeEmail
                       ]
                    ]
                    self.database.child("users").setValue(newCollection, withCompletionBlock: {
                        error, _ in
                        guard  error == nil else
                        {
                            completion(false)
                            return
                        }
                        completion(true)
                    })
                }
                
            })
            
           // completion(true)
        })
    }
    
    public func getAllUsers(completion: @escaping (Result<[[String: String]], Error>) -> Void)
    {
        database.child("users").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as?  [[String: String]] else
            {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            completion(.success(value))
            
        })
    }
    public enum DatabaseError: Error {
        case failedToFetch
    }

}


extension DatabaseManager{
    public func createnewConversation(with otheruserEmail: String, firstMessage: Message, completion: @escaping (Bool) -> Void)
    {
        guard let currentEmail = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAdress: currentEmail)
        let ref = database.child("\(safeEmail)")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            guard var userNode = snapshot.value as?  [String: Any] else {
                completion(false)
                print("User not found")
                return
            }
            
            let messageDate = firstMessage.sentDate
           let dateString = ChatViewController.dateFormatter.string(from: messageDate)
            var message = ""
            
            switch firstMessage.kind{
                
            case .text(let messageText):
                message = messageText
                break
            case .attributedText(_):
                break
            case .photo(_):
                break
            case .video(_):
                break
            case .location(_):
                break
            case .emoji(_):
                break
            case .audio(_):
                break
            case .contact(_):
                break
            case .linkPreview(_):
                break
            case .custom(_):
                break
            }
            
            let conversationId = "conversation_\(firstMessage.messageId)"
            let newConversationData: [String: Any] = [
                "id": conversationId,
                "other_user_email": otheruserEmail,
                "latest_message": [
                    "date": dateString,
                    "message": message,
                    "is_read": false
                ]
            ]

            
            if var conversations = userNode["conversations"] as? [[String: Any]] {
                conversations.append(newConversationData)
                userNode["conversations"] = conversations
                ref.setValue(userNode, withCompletionBlock: { [weak self] error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    self?.finishCreatingConversation(conversationID: conversationId, firstMessage: firstMessage, completion: completion)
                })
            }
            else
            {
                userNode["conversations"] = [
                    newConversationData
                ]
                ref.setValue(userNode, withCompletionBlock: { [weak self] error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    self?.finishCreatingConversation(conversationID: conversationId, firstMessage: firstMessage, completion: completion)
                   
                })
            }
        })
        
    }
    private func finishCreatingConversation(conversationID: String, firstMessage: Message, completion: @escaping (Bool) -> Void)
    {
        let messageDate = firstMessage.sentDate
        let dateString =  ChatViewController.dateFormatter.string(from: messageDate)
        
        var message = ""
        
        switch firstMessage.kind{
            
        case .text(let messageText):
            message = messageText
            break
        case .attributedText(_):
            break
        case .photo(_):
            break
        case .video(_):
            break
        case .location(_):
            break
        case .emoji(_):
            break
        case .audio(_):
            break
        case .contact(_):
            break
        case .linkPreview(_):
            break
        case .custom(_):
            break
        }
        
        guard let myEmail = UserDefaults.standard.value(forKey: "email") as? String else {
            completion(false)
            return
        }
        let currentUserEmail = DatabaseManager.safeEmail(emailAdress: myEmail)
        
        let collectionMessage: [String: Any] = [
            "id": firstMessage.messageId,
            "type": firstMessage.kind.messageKinString,
            "content": "",
            "date": dateString,
            "sender_email": currentUserEmail,
            "is_read": false
        ]
        
        let value: [String: Any] = [
            "messages": [
                collectionMessage
            ]
        ]
        print("adding convo: \(conversationID)")
        
        database.child("\(conversationID)").setValue(value, withCompletionBlock: { error, _ in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
            
        })
    }
    public func getAllConversation(for email: String, completion: @escaping (Result<String, Error>) -> Void)
    {
        
    }
    
    public func getAllConversationWithEmail(for id: String, completion: @escaping (Result<String, Error>) -> Void)
    {
        
    }
    
    public func sentMessage(to conversation: String, message: Message, completion: @escaping(Bool) -> Void)
    {
        
    }
    
    
}

struct chatappUser
{
    let firstName: String
    let emailAddress: String
    let phoneNumber: String
    let Gender: Bool
    var safeEmail: String
    {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    var profilepictureFileName: String {
        return "\(safeEmail) profile_picture.png"
    }
}
