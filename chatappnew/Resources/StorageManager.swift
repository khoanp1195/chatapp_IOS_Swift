//
//  StorageManager.swift
//  chatappnew
//
//  Created by NguyenPhuongkhoa on 19/07/2023.
//

import Foundation
import FirebaseStorage

final class StorageManager
{
    static let shared =  StorageManager()
    
    private let storage = Storage.storage().reference()
    
    /*
     //
     */
    
    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    
    //Upload picture to firebase
    public func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion)
    {
        storage.child("image/\(fileName)").putData(data,metadata: nil, completion: { metaData, error in  guard error == nil else {
            //failed
            print("failed yo upload data to firebase for picture")
            completion(.failure(StorageErrors.failedToUpload))
            return
        }
            self.storage.child("image/\(fileName)").downloadURL(completion: { url, error in
                guard let url = url else
                {
                    print("failed to get dowload url")
                    completion(.failure(StorageErrors.failedToGetDowloadURL))
                    return
                }
                
                let urlString = url.absoluteString
                print("dowload url returned: \(urlString)")
                completion(.success(urlString))
                
            })
            
            
            
        })
        
    }
    
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDowloadURL
    }
    
    public func dowloadURL(for path: String,  completion: @escaping (Result<URL, Error>) -> Void)
    {
        let reference = storage.child(path)
        
        reference.downloadURL(completion: { url, error in
            guard let url = url, error == nil else
            {
                completion(.failure(StorageErrors.failedToGetDowloadURL))
                return
            }
            completion(.success(url))
        })
    }
    
}
