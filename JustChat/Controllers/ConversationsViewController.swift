//
//  ConversationsViewController.swift
//  JustChat
//
//  Created by Ангел предохранитель on 02.11.2024.
//

import UIKit

class ConversationsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
        if !isLoggedIn {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            
            nav.modalPresentationStyle = .fullScreen
            
            present(nav, animated: false)
        }
    }
}
