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
    public func insertUser(with user: chatappUser)
    {
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "phone_numer": user.phoneNumber,
            "Gender": user.Gender
        ])
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
}
