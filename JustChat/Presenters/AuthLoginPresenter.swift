//
//  AuthLoginPresenter.swift
//  JustChat
//
//  Created by Ангел предохранитель on 06.11.2024.
//

import UIKit

protocol LoginViewInput: AnyObject {
    func didLoginTapped(email: String, password: String)
    
    func failedLogin(error: String)
    func successfullyLoggedIn(uid: String)
}

protocol LoginViewOutput: AnyObject {
    func login(email: String, password: String)
}

final class AuthLoginPresenter {
    
    var loginView: LoginViewInput?
    var authManager: AuthManagerProtocol
    var dataManager: DataBaseManagerProtocol
    
    init(
        authManager: AuthManagerProtocol,
        dataManager: DataBaseManagerProtocol,
        loginView: LoginViewInput? = nil) {
            self.loginView = loginView
            self.authManager = authManager
            self.dataManager = dataManager
        }
}

extension AuthLoginPresenter: LoginViewOutput {
    
    func login(email: String, password: String) {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let self else { return }
            
            self.authManager.loginUser(
                email: email,
                password: password
            ) { [weak self] result in
                guard let self else { return }
                
                switch result {
                    
                case .success(let uid):
                    guard let uid else { return }
                    
                    self.loginView?.successfullyLoggedIn(uid: uid)
                    
                case .failure(let error):
                    self.loginView?.failedLogin(error: error.localizedDescription)
                }
            }
        }
    }
}
