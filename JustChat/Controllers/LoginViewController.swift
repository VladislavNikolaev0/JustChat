//
//  LoginViewController.swift
//  JustChat
//
//  Created by Ангел предохранитель on 02.11.2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Log In"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
    }
    
    @objc
    func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Register"
        navigationController?.pushViewController(vc, animated: true)
    }
}
