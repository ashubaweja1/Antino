//
//  UserListHandler.swift
//  Test
//
//  Created by Ashu Baweja on 15/05/20.
//  Copyright © 2019 Ashu Baweja. All rights reserved.
//

import Foundation
import UIKit

// MARK: Api Related Methods
class UserListHandler {
    
    /// This method will fetch the user list from server
    /// - Parameter completionHandler: return user list or error
    class func fetchUserList(completionHandler: (([User]?, _ error : Error?) -> Void)? = nil) {
        
        NetworkManager.sendRequest(requestUrl: kUserListUrl, type: .Get, params: nil) { (json, error) in
            var users: [User]?
            if let listJson = json as? [[String: Any]] {
                users = []
                for userJson in listJson {
                    let user = User(json: userJson)
                    users?.append(user)
                }
                completionHandler?(users, error)
            }
        }
    }
    
    
    /// This method will save image to document directory
    class func saveImageToDirectory(data: Data, imageName: String){
        let fileURL = getFileUrl(imageName: imageName)
        do {
            try data.write(to: fileURL)
        } catch {
            print("error saving file:", error)
        }
    }
    
    /// This method will generate the url of image file in document directory
    class func getFileUrl(imageName: String) -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = imageName + ".jpg"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        return fileURL
    }
    
    /// This method will check whether image file exists in documennt directory or not
    class func checkIfImageExists(fileURL: URL) -> Bool{
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
    
    /// This method will fetch image from document directory
    class func getImageFromDirectory(path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: path)
        return image
    }
}




