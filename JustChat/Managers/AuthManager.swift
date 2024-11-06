//
//  AuthManager.swift
//  JustChat
//
//  Created by Ангел предохранитель on 05.11.2024.
//

import UIKit
import FirebaseAuth

protocol AuthManagerProtocol: AnyObject {
    func currentUsers() -> FirebaseAuth.User?
    func userIsAuthorized() -> Bool
    func loginUser(
        email: String,
        password: String,
        completion: @escaping (Result <String?, Error>) -> Void
    )
    func registerNewUser(
        email: String,
        password: String,
        completion: @escaping (Result<String?, Error>) -> Void
    )
    func signOut(competion: @escaping (Result<Void, Error>) -> Void)
}

final class AuthManager: AuthManagerProtocol {
    
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    private init() {}
    
    func currentUsers() -> FirebaseAuth.User? {
        return auth.currentUser
    }
    
    func userIsAuthorized() -> Bool {
        return auth.currentUser != nil
    }
    
    func loginUser(
        email: String,
        password: String,
        completion: @escaping (Result<String?, any Error>) -> Void
    ) {
        auth.signIn(withEmail: email, password: password) { authData, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            completion(.success(authData?.user.uid))
        }
    }
    
    func registerNewUser(
        email: String,
        password: String,
        completion: @escaping (Result<String?, any Error>) -> Void
    ) {
        auth.createUser(withEmail: email, password: password) { authData, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            completion(.success(authData?.user.uid))
        }
    }
    
    func signOut(competion: @escaping (Result<Void, any Error>) -> Void) {
        do {
            try auth.signOut()
            competion(.success(()))
        } catch {
            competion(.failure(error))
        }
    }
    
}
