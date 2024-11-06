//
//  StandartTextField.swift
//  JustChat
//
//  Created by Ангел предохранитель on 03.11.2024.
//

import UIKit

enum TextFieldType {
    case standart
    case secure
}

class StandartTextField: UITextField {
    
    private var type: TextFieldType
    private var isLast: Bool
    private var placholder: String?
    
    init(type: TextFieldType, isLast: Bool, placeholder: String?){
        self.type = type
        self.isLast = isLast
        self.placholder = placeholder
        super.init(frame: .zero)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints(from: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: from.bottomAnchor, constant: 10),
            centerXAnchor.constraint(equalTo: from.centerXAnchor),
            heightAnchor.constraint(equalToConstant: 40),
            widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    private func configure() {
        autocapitalizationType = .none
        autocorrectionType = .no
        returnKeyType = isLast ? .done : .continue
        font = .systemFont(ofSize: 12)
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        placeholder = placholder ?? ""
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        leftViewMode = .always
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        if type == .secure {
            isSecureTextEntry = true
            textContentType = .oneTimeCode
        }
    }
}
