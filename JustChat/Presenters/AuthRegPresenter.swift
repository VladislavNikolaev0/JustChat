//
//  AuthRegPresenter.swift
//  JustChat
//
//  Created by Ангел предохранитель on 05.11.2024.
//

import UIKit

protocol LoginViewInput: AnyObject {
    func didLoginTapped()
}

protocol LoginViewOutput: AnyObject {
    func login(email: String, password: String)
}

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
        authManager.registerNewUser(email: email, password: password) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let uid):
                guard let uid else { return }
                dataManager.save(
                    user: User(
                        uid: uid,
                        firstName: firstName,
                        lastName: lastName,
                        email: email
                    )) { [weak self] error in
                        if let error {
                            DispatchQueue.main.async { [weak self] in
                                self?.registrationView?.failedRegister(error: error.localizedDescription)
                            }
                        }
                    }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.registrationView?.failedRegister(error: error.localizedDescription)
                }
            }
        }
    }
}
