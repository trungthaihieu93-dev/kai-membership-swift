//
//  PasswordViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 08/03/2021.
//

import UIKit
import RxSwift

class PasswordViewController: BaseViewController {

    // MARK: Properties
    enum `Type` {
        case new
        case change
    }
    
    private let type: `Type`
    
    let viewModel = PasswordViewModel()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.attributedText = "Your new password must be different from previous used one. Try to remember it this time.".setTextWithFormat(font: .workSansFont(ofSize: 14, weight: .medium), lineHeight: 28, textColor: UIColor.black.withAlphaComponent(0.54))
        
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private(set) lazy var inputPasswordView: KAIInputTextFieldView = {
        let view = KAIInputTextFieldView(with: .password, title: "NEW PASSWORD", placeholder: "New password")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    private(set) lazy var confirmPasswordView: KAIInputTextFieldView = {
        let view = KAIInputTextFieldView(with: .password, title: "CONFIRM PASSWORD", placeholder: "Confirm password")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    private(set) lazy var inputTokenView: KAIInputTextFieldView = {
        let view = KAIInputTextFieldView(with: .default, title: "PASTE YOUR TOKEN HERE", placeholder: "Paste your token here")
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
        button.isEnabled = false
        button.backgroundColor = .init(hex: "E1E4E8")
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(onPressedSetNew), for: .touchUpInside)
        
        return button
    }()
    
    private var confirmBottomAnchor: NSLayoutConstraint?
    
    var isConfirmEnabled: Bool = false {
        didSet {
            guard isConfirmEnabled != oldValue else { return }
            
            setNewPasswordButton.isEnabled = isConfirmEnabled
            
            if isConfirmEnabled {
                setNewPasswordButton.gradientBackgroundColors([UIColor.init(hex: "394656").cgColor, UIColor.init(hex: "181E25").cgColor], direction: .vertical)
            } else {
                setNewPasswordButton.removeAllSublayers(withName: UIView.gradientLayerKey)
            }
        }
    }
    
    // MARK: Life cycle's
    init(with type: `Type`) {
        self.type = type
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "New Password"
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupView()
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTap(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.cancelsTouchesInView = true
        scrollView.addGestureRecognizer(singleTap)
    }
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(descriptionLabel)
        view.addSubview(scrollView)
        view.addSubview(setNewPasswordButton)
        
        scrollView.addSubview(inputPasswordView)
        scrollView.addSubview(confirmPasswordView)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            scrollView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            inputPasswordView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            inputPasswordView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            inputPasswordView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            inputPasswordView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            
            confirmPasswordView.topAnchor.constraint(equalTo: inputPasswordView.bottomAnchor, constant: 8),
            confirmPasswordView.leadingAnchor.constraint(equalTo: inputPasswordView.leadingAnchor),
            confirmPasswordView.trailingAnchor.constraint(equalTo: inputPasswordView.trailingAnchor),
            
            setNewPasswordButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 32),
            setNewPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            setNewPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            setNewPasswordButton.heightAnchor.constraint(equalToConstant: 52),
        ])
        
        if type == .new {
            scrollView.addSubview(inputTokenView)
            
            inputTokenView.topAnchor.constraint(equalTo: confirmPasswordView.bottomAnchor, constant: 8).isActive = true
            inputTokenView.leadingAnchor.constraint(equalTo: inputPasswordView.leadingAnchor).isActive = true
            inputTokenView.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor).isActive = true
            inputTokenView.trailingAnchor.constraint(equalTo: inputPasswordView.trailingAnchor).isActive = true
        } else {
            confirmPasswordView.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor).isActive = true
        }
        
        confirmBottomAnchor = setNewPasswordButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(safeAreaInsets.bottom + 20))
        confirmBottomAnchor?.isActive = true
    }
}

// MARK: Handle actions
extension PasswordViewController {
    
    @objc private func handleKeyboardNotification(_ notification: NSNotification) {
        if notification.name == UIResponder.keyboardWillShowNotification {
            guard let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            confirmBottomAnchor?.constant = -(keyboardFrame.height + 20)
        } else {
            confirmBottomAnchor?.constant = -(safeAreaInsets.bottom + 20)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func onPressedSetNew() {
        guard confirmPasswordView.contentInput == inputPasswordView.contentInput else {
            debugPrint("Xác nhận lại mật khẩu không đúng")
            
            return
        }
        
        switch type {
        case .new:
            viewModel.confirmPassword(with: inputTokenView.contentInput, password: confirmPasswordView.contentInput).subscribe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
                guard let this = self else { return }
                
                Navigator.navigateToCongratsVC(from: this, with: .password)
            }, onError: { error in
                debugPrint("Request forgot password by email error: \((error as? APIErrorResult)?.message ?? "ERROR")")
            }).disposed(by: disposeBag)
        case .change:
            viewModel.changePassword(password: "", newPassword: confirmPasswordView.contentInput).subscribe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
                guard let this = self else { return }
                
                //
            }, onError: { error in
                debugPrint("Change password error: \((error as? APIErrorResult)?.message ?? "ERROR")")
            }).disposed(by: disposeBag)
        }
    }
    
    @objc private func handleSingleTap(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
