//
//  RegistrationViewAssembly.swift
//  JustChat
//
//  Created by Ангел предохранитель on 05.11.2024.
//

import UIKit

final class RegistrationViewAssembly {
    
    static func assembly() -> RegisterViewController {
        
        let authManager = AuthManager.shared
        let dataManager = DataBaseManager.shared
        
        let presentor = AuthRegPresenter(authManager: authManager, dataManager: dataManager)
        let view = RegisterViewController(output: presentor)
        presentor.registrationView = view
        
        return view
    }
}
