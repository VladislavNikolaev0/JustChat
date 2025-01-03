//
//  LoginViewController.swift
//  JustChat
//
//  Created by Ангел предохранитель on 02.11.2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    var output: LoginViewOutput
    
    // MARK: - Private Properties
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.clipsToBounds = true
        scroll.isUserInteractionEnabled = true
        scroll.isScrollEnabled = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var emailTextField = StandartTextField(
        type: .standart,
        isLast: false,
        placeholder: "Email"
    )
    
    private lazy var passwordTextField = StandartTextField(
        type: .secure,
        isLast: true,
        placeholder: "Password"
    )
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(output: LoginViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            loginButtonTapped()
        }
        
        return true
    }
}

// MARK: - Private Methods

private extension LoginViewController {
    
    func setupUI() {
        
        view.backgroundColor = .white
        title = "Log In"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Register",
            style: .done,
            target: self,
            action: #selector(didTapRegister)
        )
        
        loginButton.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside
        )
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        setupHierarchy()
        setupConstraints()
    }
    
    func setupHierarchy() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(loginButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            emailTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            emailTextField.widthAnchor.constraint(equalToConstant: 250),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.widthAnchor.constraint(equalToConstant: 250),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 200),
            loginButton.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            loginButton.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    func alertUsingLoginError(message: String? = nil) {
        let alert = UIAlertController(
            title: "Log In Error",
            message: message != nil ? message : "Try use @ in email or/and password is less than 6 characters",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(
            title: "Dismiss",
            style: .cancel)
        )
        
        present(alert, animated: true)
    }
    
    // MARK: - Actions
    
    @objc
    func didTapRegister() {
        let vc = RegistrationViewAssembly.assembly()
        vc.title = "Register"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func loginButtonTapped() {
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              !email.isEmpty,
              !password.isEmpty,
              email.contains("@"),
              password.count >= 6
        else {
            alertUsingLoginError()
            return
        }
        
        didLoginTapped(email: email, password: password)
    }

}

extension LoginViewController: LoginViewInput {
    
    func didLoginTapped(email: String, password: String) {
        output.login(email: email, password: password)
    }
    
    func failedLogin(error: String) {
        alertUsingLoginError(message: error)
    }
    
    func successfullyLoggedIn(uid: String) {
        print("User \(uid) successfully logged in")
    }
}
