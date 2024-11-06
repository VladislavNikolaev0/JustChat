//
//  User.swift
//  JustChat
//
//  Created by Ангел предохранитель on 05.11.2024.
//

import Foundation

struct User {
    var uid: String
    var firstName: String
    var lastName: String
    var email: String
    
    init(
        uid: String,
        firstName: String,
        lastName: String,
        email: String
    ) {
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    
    init(dict: [String: Any]) {
        self.uid = dict["uid"] as? String ?? ""
        self.firstName = dict["firstName"] as? String ?? ""
        self.lastName = dict["lastName"] as? String ?? ""
        self.email = dict["email"] as? String ?? ""
    }
}

extension User {
    func toDict() -> [String: Any] {
        return [
            "uid": uid,
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
        ]
    }
}
