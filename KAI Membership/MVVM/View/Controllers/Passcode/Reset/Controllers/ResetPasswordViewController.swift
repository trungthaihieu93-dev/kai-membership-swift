//
//  ResetPasscodeViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 20/02/2021.
//

import UIKit
import RxSwift

class ResetPasscodeViewController: BaseViewController {

    // MARK: Properties
    let viewModel = ResetPasswordViewModel()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.attributedText = "We will send an email with instructions to your registed email.".setTextWithFormat(font: .workSansFont(ofSize: 14, weight: .medium), lineHeight: 28, textColor: UIColor.black.withAlphaComponent(0.54))
        
        return label
    }()
    
    private lazy var emailTextField: KAIInputTextFieldView = {
        let view = KAIInputTextFieldView(with: .default, title: "EMAIL", placeholder: "an.nguyen@kardiachain.io", keyboardType: .emailAddress)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(NSAttributedString(string: "Send Instructions", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 16, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]), for: .normal)
        button.isEnabled = false
        button.backgroundColor = .init(hex: "E1E4E8")
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(onPressedSend), for: .touchUpInside)
        
        return button
    }()
    
    var isConfirmEnabled: Bool = false {
        didSet {
            guard isConfirmEnabled != oldValue else { return }
            
            sendButton.isEnabled = isConfirmEnabled
            
            if isConfirmEnabled {
                sendButton.gradientBackgroundColors([UIColor.init(hex: "394656").cgColor, UIColor.init(hex: "181E25").cgColor], direction: .vertical)
            } else {
                sendButton.removeAllSublayers(withName: UIView.gradientLayerKey)
            }
        }
    }
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Reset Passcode"
        setupView()
    }
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(descriptionLabel)
        view.addSubview(emailTextField)
        view.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            sendButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            sendButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            sendButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -(safeAreaInsets.bottom + 24)),
            sendButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            sendButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
}

// MARK: Handle actions
extension ResetPasscodeViewController {
    
    @objc private func onPressedSend() {
        viewModel.requestResetPassword(with: emailTextField.contentInput).subscribe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let this = self else { return }
            
            Navigator.navigateToCheckMailVC(from: self)
        }, onError: { error in
            debugPrint("Request forgot password by email error: \((error as? APIErrorResult)?.message ?? "ERROR")")
        }).disposed(by: disposeBag)
    }
}
