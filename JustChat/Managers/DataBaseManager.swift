//
//  DataBaseManager.swift
//  JustChat
//
//  Created by Ангел предохранитель on 05.11.2024.
//

import FirebaseFirestore

protocol DataBaseManagerProtocol {
    func save(user: User, completion: @escaping (Error?) -> Void)
}

class DataBaseManager: DataBaseManagerProtocol {
    
    static let shared = DataBaseManager()
    
    private init() {}
    
    func save(user: User, completion: @escaping (Error?) -> Void) {
        let collection = Firestore.firestore().collection("Users").document(user.uid)
        collection.setData(user.toDict(), completion: completion)
    }
    
}
