//
//  RegisterViewController.swift
//  JustChat
//
//  Created by Ангел предохранитель on 02.11.2024.
//

import UIKit

class RegisterViewController: UIViewController {
    
    var output: RegisterViewOutput
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.clipsToBounds = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var profilePhoto: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo.circle.fill")
        image.contentMode = .scaleAspectFit
        image.tintColor = .systemGray
        image.isUserInteractionEnabled = true
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var firstNameTextField = StandartTextField(
        type: .standart,
        isLast: false,
        placeholder: "First Name"
    )
    
    private lazy var lastNameTextField = StandartTextField(
        type: .standart,
        isLast: false,
        placeholder: "Last Name"
    )
    
    private lazy var emailTextField = StandartTextField(
        type: .standart,
        isLast: false,
        placeholder: "Email"
    )
    
    private lazy var passwordTextField = StandartTextField(
        type: .secure,
        isLast: false,
        placeholder: "Password"
    )
    
    private lazy var repeatPasswordTextField = StandartTextField(
        type: .secure,
        isLast: true,
        placeholder: "Repeat Password"
    )
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(output: RegisterViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        profilePhoto.layoutIfNeeded()
        profilePhoto.layer.borderWidth = 2
        profilePhoto.layer.borderColor = UIColor.systemGray.cgColor
        profilePhoto.layer.cornerRadius = profilePhoto.bounds.width / 2
    }
}

private extension RegisterViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        
        setTargets()
        setupHierarchy()
        setupConstraints()
    }
    
    func setTargets() {
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(photoProfileTapped))//UIGestureRecognizer(target: self, action: #selector(photoProfileTapped))
        profilePhoto.addGestureRecognizer(gesture)
        
        
    }
    
    func setupHierarchy() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(profilePhoto)
        scrollView.addSubview(firstNameTextField)
        scrollView.addSubview(lastNameTextField)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(repeatPasswordTextField)
        scrollView.addSubview(registerButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            profilePhoto.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            profilePhoto.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            profilePhoto.heightAnchor.constraint(equalToConstant: 150),
            profilePhoto.widthAnchor.constraint(equalToConstant: 150),
            
            firstNameTextField.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 50),
            firstNameTextField.centerXAnchor.constraint(equalTo: profilePhoto.centerXAnchor),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 40),
            firstNameTextField.widthAnchor.constraint(equalToConstant: 250),
        ])
        
        lastNameTextField.setConstraints(from: firstNameTextField)
        emailTextField.setConstraints(from: lastNameTextField)
        passwordTextField.setConstraints(from: emailTextField)
        repeatPasswordTextField.setConstraints(from: passwordTextField)
        
        setButtonConstraints()
    }
    
    func setButtonConstraints() {
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 100),
            registerButton.centerXAnchor.constraint(equalTo: repeatPasswordTextField.centerXAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 60),
            registerButton.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    func alertUsingRegisterError(message: String? = nil) {
        let alert = UIAlertController(
            title: "Register Error",
            message: message != nil ? message : "Try use @ in email or/and password is less than 6 characters",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(
            title: "Dismiss",
            style: .cancel))
        
        present(alert, animated: true)
    }
    
    func alertPasswordError() {
        let alert = UIAlertController(
            title: "Password Error",
            message: "Passwords not equal",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(
            title: "Dismiss",
            style: .cancel))
        
        present(alert, animated: true)
    }
    
    @objc
    func registerButtonTapped() {
        
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        repeatPasswordTextField.resignFirstResponder()
        
        guard let firstName = firstNameTextField.text,
              let lastName = lastNameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              let repeatPassword = repeatPasswordTextField.text,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              !repeatPassword.isEmpty,
              password == repeatPassword,
              password.count >= 6,
              firstName.isValidName,
              lastName.isValidName,
              password.isValidPassword,
              email.isValidEmailAddress else {
            alertUsingRegisterError()
            return
        }
        
        didRegisterTapped(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password
        )
    }
    
    @objc
    func photoProfileTapped() {
        presentPhotoActionSheet()
    }
}

extension RegisterViewController: RegisterViewInput {
    
    func failedRegister(error: String) {
        alertUsingRegisterError(message: error)
    }
    
    
    func didRegisterTapped(
        firstName: String,
        lastName: String,
        email: String,
        password: String
    ) {
        output.register(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password
        )
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(
            title: "Pictures for profile",
            message: "How would u like chose a photo?",
            preferredStyle: .alert
        )
        
        actionSheet.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil))
        
        actionSheet.addAction(UIAlertAction(
            title: "Take photo",
            style: .default
        ) { [weak self] _ in
            self?.presentCamera()
        })
        
        actionSheet.addAction(UIAlertAction(
            title: "Chose a photo",
            style: .default
        ) { [weak self] _ in
            self?.presentPhotoPicker()
        })
        
        present(actionSheet,animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        let selectedImage = info[.editedImage] as? UIImage
        self.profilePhoto.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
