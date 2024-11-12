//
//  AuthRegPresenter.swift
//  JustChat
//
//  Created by Ангел предохранитель on 05.11.2024.
//

import UIKit

protocol RegisterViewInput: AnyObject {
    func didRegisterTapped(
        firstName: String,
        lastName: String,
        email: String,
        password: String
    )
    
    func failedRegister(error: String)
}

protocol RegisterViewOutput: AnyObject {
    func register(firstName: String, lastName: String,  email: String, password: String)
}

final class AuthRegPresenter {
    
    var registrationView: RegisterViewInput?
    var authManager: AuthManagerProtocol
    var dataManager: DataBaseManagerProtocol
    
    init(authManager: AuthManagerProtocol, dataManager: DataBaseManagerProtocol, registrationView: RegisterViewInput? = nil) {
        self.registrationView = registrationView
        self.authManager = authManager
        self.dataManager = dataManager
    }
}

extension AuthRegPresenter: RegisterViewOutput {
    
    func register(
        firstName: String,
        lastName: String,
        email: String,
        password: String
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            self.authManager.registerNewUser(email: email, password: password) { result in
                
                switch result {
                    
                case .success(let uid):
                    guard let uid else { return }
                    self.dataManager.save(
                        user: User(
                            uid: uid,
                            firstName: firstName,
                            lastName: lastName,
                            email: email
                        )) { error in
                            if let error {
                                self.registrationView?.failedRegister(error: error.localizedDescription)
                            }
                        }
                    
                case .failure(let error):
                    self.registrationView?.failedRegister(error: error.localizedDescription)
                }
            }
        }
    }
}
