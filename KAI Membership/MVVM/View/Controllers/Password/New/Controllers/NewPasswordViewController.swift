//
//  NewPasswordViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 08/03/2021.
//

import UIKit

class NewPasswordViewController: BaseViewController {

    // MARK: Properties
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var passwordTextField: KAIInputTextFieldView = {
        let view = KAIInputTextFieldView(title: "NEW PASSWORD", placeholder: "New password", isSecureTextEntryEnabled: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    private lazy var confirmPasswordTextField: KAIInputTextFieldView = {
        let view = KAIInputTextFieldView(title: "CONFIRM PASSWORD", placeholder: "Confirm password", isSecureTextEntryEnabled: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    private lazy var tokenTextField: KAIInputTextFieldView = {
        let view = KAIInputTextFieldView(title: "PASTE YOUR TOKEN HERE", placeholder: "Paste your token here", isSecureTextEntryEnabled: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    private lazy var setNewPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(NSAttributedString(string: "Set new Password", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 16, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(onPressedSetNew), for: .touchUpInside)
        
        return button
    }()
    
    override var pageTitle: String {
        return "New Password"
    }
    
    override var pageDiscription: String {
        return "Your new password must be different from previous used one. Try to remember it this time."
    }
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: Layout
    private func setupView() {
        contentView.addSubview(scrollView)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(confirmPasswordTextField)
        scrollView.addSubview(tokenTextField)
        
        contentView.addSubview(setNewPasswordButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: pageTitleView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: scrollView.topAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            tokenTextField.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 8),
            tokenTextField.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            tokenTextField.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            setNewPasswordButton.topAnchor.constraint(equalTo: tokenTextField.bottomAnchor, constant: 32),
            setNewPasswordButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            setNewPasswordButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(safeAreaInsets.bottom + 24)),
            setNewPasswordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            setNewPasswordButton.heightAnchor.constraint(equalToConstant: 52),
        ])
        
        DispatchQueue.main.async {
            self.setNewPasswordButton.gradientBackgroundColors([UIColor.init(hex: "394656").cgColor, UIColor.init(hex: "181E25").cgColor], direction: .vertical)
        }
    }
}

// MARK: Handle actions
extension NewPasswordViewController {
    
    @objc private func onPressedSetNew() {
        
    }
}
