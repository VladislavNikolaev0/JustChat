//
//  AuthLoginPresenter.swift
//  JustChat
//
//  Created by Ангел предохранитель on 06.11.2024.
//

import UIKit

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
        authManager.loginUser(
            email: email,
            password: password
        ) { [weak self] result in
            guard let self else { return }
            
            switch result {
                
            case .success(let uid):
                guard let uid else { return }
                
                
            case .failure(let error):
                DispatchQueue.main.async {
                    
                }
            }
        }
    }
}
