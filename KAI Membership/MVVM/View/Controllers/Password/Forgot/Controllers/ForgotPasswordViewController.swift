//
//  ForgotPasswordViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 20/02/2021.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {

    // MARK: Properties
    private let sendCodeToEmail: String = "Did not receive any email?\nCheck your spam filter, or resend another mail"
    private let detectActionSendCodeToEmail: String = "resend another mail"
    
    private let emailTextField: KAIInputTextFieldView = {
        let view = KAIInputTextFieldView(title: "EMAIL", placeholder: "Enter your email")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(NSAttributedString(string: "Send Instructions", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 16, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(onPressedSend), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var sendCodeToEmailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.numberOfLines = 2
        label.textAlignment = .center
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapSendCodeToEmail(_:))))
        
        return label
    }()
    
    override var pageTitle: String {
        return "Forgot Password"
    }
    
    override var pageDiscription: String {
        return "We will send an instruction to your email."
    }
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(emailTextField)
        view.addSubview(sendButton)
        view.addSubview(sendCodeToEmailLabel)
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: pageTitleView.bottomAnchor, constant: 32),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            sendButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            sendButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            sendButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            sendButton.heightAnchor.constraint(equalToConstant: 52),
            
            sendCodeToEmailLabel.topAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: 24),
            sendCodeToEmailLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            sendCodeToEmailLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -(safeAreaInsets.bottom + 24)),
            sendCodeToEmailLabel.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor)
        ])
        
        configureSendCodeToEmailLabel()
        
        DispatchQueue.main.async {
            self.sendButton.gradientBackgroundColors([UIColor.init(hex: "394656").cgColor, UIColor.init(hex: "181E25").cgColor], direction: .vertical)
        }
    }
    
    private func configureSendCodeToEmailLabel() {
        let mutableAttributedString = sendCodeToEmail.setTextWithFormat(font: .workSansFont(ofSize: 14, weight: .medium), textAlignment: .center, lineHeight: 28, textColor: UIColor.black.withAlphaComponent(0.54))
        let range = (sendCodeToEmail as NSString).range(of: detectActionSendCodeToEmail)
        mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.workSansFont(ofSize: 14, weight: .medium), range: range)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(hex: "94A2B2"), range: range)
        
        sendCodeToEmailLabel.attributedText = mutableAttributedString
    }
}

// MARK: Handle actions
extension ForgotPasswordViewController {
    
    @objc private func onPressedSend() {
        // Call APi
        Navigator.navigateToNewPasswordVC(from: self)
    }
    
    @objc private func onTapSendCodeToEmail(_ recognizer: UITapGestureRecognizer) {
        let range = (sendCodeToEmail as NSString).range(of: detectActionSendCodeToEmail)

        guard recognizer.didTapAttributedTextInLabel(label: sendCodeToEmailLabel, inRange: range) else { return }
        
    }
}
