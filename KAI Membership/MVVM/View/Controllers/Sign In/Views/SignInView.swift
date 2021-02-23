//
//  SignInView.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 20/02/2021.
//

import UIKit

class SignInView: UIView {

    // MARK: Properties
    enum ActionKey {
        case forgotPassword
        case signIn
        case createAccount
    }
    
    private let signUpText: String = "Not a KAISER yet? Create account"
    private let detechActionSignUpText: String = "Create account"
    
    private let emailTextField: KAIInputTextFieldView = {
        let view = KAIInputTextFieldView(title: "EMAIL", placeholder: "eg. an.nguyen@kardianchain.io")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let passwordTextField: KAIInputTextFieldView = {
        let view = KAIInputTextFieldView(title: "PASSWORD", placeholder: "Your password", isSecureTextEntryEnabled: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(NSAttributedString(string: "Forgot password?", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.init(hex: "94A2B2")
        ]), for: .normal)
        button.contentEdgeInsets = .init(top: 8, left: 0, bottom: 8, right: 0)
        button.addTarget(self, action: #selector(onPressedForgotPassword), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(NSAttributedString(string: "Sign in", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(onPressedSignIn), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.numberOfLines = 1
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapCreateAccount(_:))))
        
        return label
    }()
    
    var completion: ((ActionKey) -> Void)?
    
    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: Layout
    func commonInit() {
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(forgotPasswordButton)
        addSubview(signInButton)
        addSubview(signUpLabel)
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: topAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            forgotPasswordButton.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            signInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 8),
            signInButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalToConstant: 52),
            
            signUpLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            signUpLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            signUpLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
        
        configureSignUpLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.signInButton.gradientBackgroundColors([UIColor.init(hex: "394656").cgColor, UIColor.init(hex: "181E25").cgColor], direction: .vertical)
    }

    private func configureSignUpLabel() {
        let mutableAttributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: signUpText, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.54)
        ]))
        
        let range = (signUpText as NSString).range(of: detechActionSignUpText)
        mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14, weight: .regular), range: range)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(hex: "94A2B2"), range: range)
        
        signUpLabel.attributedText = mutableAttributedString
    }
}

// MARK: Handle actions
extension SignInView {
    
    @objc private func onPressedForgotPassword() {
        completion?(.forgotPassword)
    }
    
    @objc private func onPressedSignIn() {
        completion?(.signIn)
    }
    
    @objc private func onTapCreateAccount(_ recognizer: UITapGestureRecognizer) {
        let range = (signUpText as NSString).range(of: detechActionSignUpText)

        guard recognizer.didTapAttributedTextInLabel(label: signUpLabel, inRange: range) else { return }
        
        completion?(.createAccount)
    }
}
