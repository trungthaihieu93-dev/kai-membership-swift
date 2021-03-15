//
//  SignUpInputView.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 07/03/2021.
//

import UIKit

protocol SignUpInputViewDelegate: class {
    func signUpInputViewEmailValueChange(_ signUpInputView: SignUpInputView, textField: UITextField)
    func signUpInputViewPasswordValueChange(_ signUpInputView: SignUpInputView, textField: UITextField)
    func signUpInputViewConfirmPasswordValueChange(_ signUpInputView: SignUpInputView, textField: UITextField)
    func signUpInputViewDidFinishTouchingAction(_ signUpInputView: SignUpInputView, actionKey: SignUpInputView.ActionKey)
}

extension SignUpInputViewDelegate {
    func signUpInputViewEmailValueChange(_ signUpInputView: SignUpInputView, textField: UITextField) {}
    func signUpInputViewPasswordValueChange(_ signUpInputView: SignUpInputView, textField: UITextField) {}
    func signUpInputViewConfirmPasswordValueChange(_ signUpInputView: SignUpInputView, textField: UITextField) {}
}

class SignUpInputView: UIView {

    // MARK: Properties
    enum ActionKey {
        case signIn
        case createAccount
    }
    
    private let signInText: String = "I’m already a KAISER ! Sign In"
    private let detechActionSignInText: String = "Sign In"
    
    private(set) lazy var emailTextField: KAIInputTextFieldView = {
        let view = KAIInputTextFieldView(with: .default, title: "EMAIL", placeholder: "eg. an.nguyen@kardianchain.io", keyboardType: .emailAddress)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    private(set) lazy var passwordTextField: KAIInputTextFieldView = {
        let view = KAIInputTextFieldView(with: .password, title: "PASSWORD", placeholder: "Your password")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    private(set) lazy var confirmPasswordTextField: KAIInputTextFieldView = {
        let view = KAIInputTextFieldView(with: .password, title: "CONFIRM PASSWORD", placeholder: "Confirm password")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(NSAttributedString(string: "Create Account", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 16, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]), for: .normal)
        button.isEnabled = false
        button.backgroundColor = .init(hex: "E1E4E8")
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(onPressedCreateAccount), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.numberOfLines = 1
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapSignIn(_:))))
        
        return label
    }()
    
    var isConfirmEnabled: Bool = false {
        didSet {
            guard isConfirmEnabled != oldValue else { return }
            
            createAccountButton.isEnabled = isConfirmEnabled
            
            if isConfirmEnabled {
                createAccountButton.gradientBackgroundColors([UIColor.init(hex: "394656").cgColor, UIColor.init(hex: "181E25").cgColor], direction: .vertical)
            } else {
                createAccountButton.removeAllSublayers(withName: UIView.gradientLayerKey)
            }
        }
    }
    
    weak var delegate: SignUpInputViewDelegate?
    
    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    func setupView() {
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(confirmPasswordTextField)
        addSubview(createAccountButton)
        addSubview(signInLabel)
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: topAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 12),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            
            createAccountButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 32),
            createAccountButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            createAccountButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            createAccountButton.heightAnchor.constraint(equalToConstant: 52),
            
            signInLabel.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 20),
            signInLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            signInLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
        
        configureSignInLabel()
    }

    private func configureSignInLabel() {
        let mutableAttributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: signInText, attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 14, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.54)
        ]))
        
        let range = (signInText as NSString).range(of: detechActionSignInText)
        mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.workSansFont(ofSize: 14, weight: .medium), range: range)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(hex: "94A2B2"), range: range)
        
        signInLabel.attributedText = mutableAttributedString
    }
}

// MARK: Handle actions
extension SignUpInputView {
    
    @objc private func onPressedCreateAccount() {
        delegate?.signUpInputViewDidFinishTouchingAction(self, actionKey: .createAccount)
    }

    @objc private func onTapSignIn(_ recognizer: UITapGestureRecognizer) {
        let range = (signInText as NSString).range(of: detechActionSignInText)

        guard recognizer.didTapAttributedTextInLabel(label: signInLabel, inRange: range) else { return }
        
        delegate?.signUpInputViewDidFinishTouchingAction(self, actionKey: .signIn)
    }
}

// MARK: KAITextFieldDelegate
extension SignUpInputView: KAITextFieldDelegate {
    
    func kAITextFieldDidChange(_ textField: UITextField, for view: UIView) {
        if textField == emailTextField {
            delegate?.signUpInputViewEmailValueChange(self, textField: textField)
        } else if textField == passwordTextField {
            delegate?.signUpInputViewEmailValueChange(self, textField: textField)
        } else if textField == confirmPasswordTextField {
            delegate?.signUpInputViewEmailValueChange(self, textField: textField)
        }
        
        isConfirmEnabled = !emailTextField.contentInput.isEmpty && (passwordTextField.contentInput.count >= Constants.lengthPasswordMinimum) && (confirmPasswordTextField.contentInput.count >= Constants.lengthPasswordMinimum)
    }
    
    func kAITextFieldShouldReturn(_ textField: UITextField, for view: UIView) -> Bool {
        return false
    }
    
    func kAITextFieldShouldClear(_ textField: UITextField, for view: UIView) -> Bool {
        return true
    }
}
