//
//  User.swift
//  Test
//
//  Created by Ashu Baweja on 15/05/20.
//  Copyright © 2019 Ashu Baweja. All rights reserved.
//

import Foundation

class User: NSObject {
    
    var name: String?
    var url: String?
    var location: String?
    var age: String?
   
    override init() {
    }
    
    
    /// This method will initialize the user model
    /// - Parameter json: json object received from server
    init(json: [String: Any]) {
        
        name = json[kName] as? String
        url = json[kUrl] as? String
        location = json[kLocation] as? String
        age = json[kAge] as? String
    }
}
