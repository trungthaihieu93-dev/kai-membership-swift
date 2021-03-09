//
//  NewPasswordViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 08/03/2021.
//

import UIKit

class NewPasswordViewController: BaseViewController2 {

    // MARK: Properties
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        return label
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
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Password"
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupView()
    }
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(contentView)
        
        contentView.addSubview(scrollView)
        contentView.addSubview(setNewPasswordButton)
        
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(confirmPasswordTextField)
        scrollView.addSubview(tokenTextField)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            descriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -40),
            
            passwordTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            tokenTextField.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 8),
            tokenTextField.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            tokenTextField.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            tokenTextField.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            setNewPasswordButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 32),
            setNewPasswordButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            setNewPasswordButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -(safeAreaInsets.bottom + 24)),
            setNewPasswordButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            setNewPasswordButton.heightAnchor.constraint(equalToConstant: 52),
        ])
        
        descriptionLabel.attributedText = "Your new password must be different from previous used one. Try to remember it this time.".setTextWithFormat(font: .workSansFont(ofSize: 14, weight: .medium), lineHeight: 28, textColor: UIColor.black.withAlphaComponent(0.54))
        
        DispatchQueue.main.async {
            self.setNewPasswordButton.gradientBackgroundColors([UIColor.init(hex: "394656").cgColor, UIColor.init(hex: "181E25").cgColor], direction: .vertical)
        }
    }
}

// MARK: Handle actions
extension NewPasswordViewController {
    
    @objc private func onPressedSetNew() {
        
    }
    
    @objc private func handleKeyboardNotification(_ notification: NSNotification) {
//        if notification.name == UIResponder.keyboardWillShowNotification {
//            guard let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
//            
//            let bottomOffset = Constants.Device.screenSize.height - (scrollView.frame.origin.y + signInView.frame.origin.y + signInView.frame.height + 10)
//            
//            if keyboardFrame.height > bottomOffset {
//                self.scrollView.setContentOffset(CGPoint(x: 0, y: keyboardFrame.height - bottomOffset), animated: true)
//            }
//        } else {
//            self.scrollView.setContentOffset(.zero, animated: true)
//        }
    }
}
