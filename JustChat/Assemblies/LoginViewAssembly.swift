//
//  LoginViewAssembly.swift
//  JustChat
//
//  Created by Ангел предохранитель on 11.11.2024.
//

import UIKit

final class LoginViewAssembly {
    
    static func assembly() -> LoginViewController {
        
        let authManager = AuthManager.shared
        let dataManager = DataBaseManager.shared
        
        let presentor = AuthLoginPresenter(authManager: authManager, dataManager: dataManager)
        let view = LoginViewController(output: presentor)
        presentor.loginView = view
        return view
    }
}
