//
//  ChatViewController.swift
//  chatappnew
//
//  Created by NguyenPhuongkhoa on 18/07/2023.
//

import UIKit
import MessageKit
import InputBarAccessoryView

struct Message: MessageType{
   public var sender: MessageKit.SenderType
    public  var messageId: String
    public var sentDate: Date
    public var kind: MessageKit.MessageKind
}

extension MessageKind {
    var messageKinString: String{
        switch self{
            
        case .text(_):
            return "text"
        case .attributedText(_):
            return "attributed_Text"
        case .photo(_):
            return "photo"
        case .video(_):
            return "video"
        case .location(_):
            return "location"
        case .emoji(_):
            return "emoji"
        case .audio(_):
            return "audio"
        case .contact(_):
            return "contact"
        case .linkPreview(_):
            return "linkPreview"
        case .custom(_):
            return "custom"
        }
    }
}

struct Sender: SenderType{
    public var photoURL: String
    public var senderId: String
    public var displayName: String
    
    
}

class ChatViewController: MessagesViewController {
    
    public static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .long
        formatter.locale = .current
        return formatter
    }()
    
    public let otherUserEmail: String
    public var isnewConversation = false
    
    
    private var messages = [Message]()
    
    private var selfSender: Sender? {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else
        {
            return nil
        }
        return Sender(photoURL: "",
         senderId: email,
         displayName: "PhuongKhoa")
    }
    
 
    init(with email: String)
    {
        self.otherUserEmail = email
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        messages.append(Message(sender: selfSender,
//                                messageId: "1",
//                                sentDate: Date(),
//                                kind: .text("Hello world Message")))
//
//        messages.append(Message(sender: selfSender,
//                                messageId: "1",
//                                sentDate: Date(),
//                                kind: .text("Hello world Messagesadasdjasdakjdjkak")))
        

        view.backgroundColor = .red
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
        messageInputBar.inputTextView.becomeFirstResponder()
        
    }

}

extension ChatViewController: InputBarAccessoryViewDelegate{
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: "", with: "").isEmpty, let selfSender = self.selfSender,
              let messageId = createMessageId()
        else
        {
            return
        }
        
        print("This is your message =>  \(text)")
        
        if isnewConversation{
            let message = Message(sender: selfSender, messageId: messageId, sentDate: Date(), kind: .text(text))
            DatabaseManager.shared.createnewConversation(with: otherUserEmail, firstMessage: message, completion: {success in
                if(success)
                {
                    print("Succes Sent")
                }
                else
                {
                    print("failed to sent")
                }
            })
        }
        else{
            
        }
    }
    
    private func createMessageId() -> String? {
        // date, otheruserEmail, senderEmail, randomint
        guard let currentUserEmail = UserDefaults.standard.value(forKey: "email") as? String else
        {
            return nil
        }
        
        let safeCurrentEmail = DatabaseManager.safeEmail(emailAdress: currentUserEmail)
        
        let dateString = Self.dateFormatter.string(from: Date())
        let newIdentifier = "\(otherUserEmail)_\(safeCurrentEmail)_\(dateString)"
        
        print("Creates message id: \(newIdentifier)")
        return newIdentifier
    }
    
}

extension ChatViewController: MessagesDataSource,MessagesLayoutDelegate, MessagesDisplayDelegate{
    func currentSender() -> SenderType {
        if let sender = selfSender
        {
            return sender
        }
        fatalError("selfsender is nil")
        return Sender(photoURL: "", senderId: "0506", displayName: "")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
}
