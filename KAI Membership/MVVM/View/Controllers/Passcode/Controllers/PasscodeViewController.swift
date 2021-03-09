//
//  PasscodeViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 23/02/2021.
//

import UIKit
import RxSwift

class PasscodeViewController: BaseViewController2 {

    // MARK: Properties
    enum `Type` {
        case signUp
        case signIn
        case confirm
        case reset
    }
    
    private let type: `Type`
    
    let viewModel: PasscodeViewModel
    
    private let footerString: String = "By creating a passcode, you agree with our \nTerms & Conditions and Privacy Policy"
    private let termsAndConditions: String = "Terms & Conditions"
    private let privacyPolicy: String = "Privacy Policy"
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var passcodeView: PasscodeView = {
        let view = PasscodeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.backgroundColor = .init(hex: "E1E4E8")
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(onPressedConfirm), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var showPasscodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(NSAttributedString(string: "Show Passcode", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 14, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.87)
        ]), for: .normal)
        button.addTarget(self, action: #selector(onPressedShowPasscode), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.numberOfLines = 2
        label.textAlignment = .center
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapFooterLabel(_:))))
        
        return label
    }()
    
    var isPasscodeShowed: Bool = false {
        didSet {
            guard isPasscodeShowed != oldValue else { return }
            
            passcodeView.isShowed = isPasscodeShowed
            
            showPasscodeButton.setAttributedTitle(NSAttributedString(string: isPasscodeShowed ? "Hide Passcode" : "Show Passcode", attributes: [
                NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 14, weight: .medium),
                NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.87)
            ]), for: .normal)
        }
    }
    
    var isConfirmEnabled: Bool = false {
        didSet {
            guard isConfirmEnabled != oldValue else { return }
            
            confirmButton.isEnabled = isConfirmEnabled
            
            if isConfirmEnabled {
                confirmButton.gradientBackgroundColors([UIColor.init(hex: "394656").cgColor, UIColor.init(hex: "181E25").cgColor], direction: .vertical)
            } else {
                confirmButton.removeAllSublayers(withName: UIView.gradientLayerKey)
            }
        }
    }
    
    // MARK: Life cycle's
    init(with type: `Type`, email: String) {
        self.type = type
        self.viewModel = PasscodeViewModel(email: email)
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Enter passcode"
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        passcodeView.inputBecomeFirstResponder()
    }
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(descriptionLabel)
        view.addSubview(passcodeView)
        view.addSubview(showPasscodeButton)
        view.addSubview(footerLabel)
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passcodeView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 52),
            passcodeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            passcodeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            showPasscodeButton.topAnchor.constraint(equalTo: passcodeView.bottomAnchor, constant: 18),
            showPasscodeButton.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: 20),
            showPasscodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showPasscodeButton.heightAnchor.constraint(equalToConstant: 40),
            
            footerLabel.topAnchor.constraint(equalTo: showPasscodeButton.bottomAnchor, constant: 94),
            footerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            footerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            confirmButton.topAnchor.constraint(equalTo: footerLabel.bottomAnchor, constant: 20),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmButton.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        configureFooterLabel()
        
        descriptionLabel.attributedText = "Enter your passcode to continue.".setTextWithFormat(font: .workSansFont(ofSize: 14, weight: .medium), lineHeight: 28, textColor: UIColor.black.withAlphaComponent(0.54))
        
        switch type {
        case .signUp:
            confirmButton.setAttributedTitle(NSAttributedString(string: "Confirm", attributes: [
                NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 16, weight: .medium),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]), for: .normal)
        case .signIn:
            confirmButton.setAttributedTitle(NSAttributedString(string: "Continue", attributes: [
                NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 16, weight: .medium),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]), for: .normal)
        case .confirm:
            confirmButton.setAttributedTitle(NSAttributedString(string: "Confirm", attributes: [
                NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 16, weight: .medium),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]), for: .normal)
        case .reset:
            confirmButton.setAttributedTitle(NSAttributedString(string: "Confirm", attributes: [
                NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 16, weight: .medium),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]), for: .normal)
        }
    }
    
    private func configureFooterLabel() {
        let mutableAttributedString = footerString.setTextWithFormat(font: .workSansFont(ofSize: 14, weight: .medium), textAlignment: .center, lineHeight: 28, textColor: UIColor.black.withAlphaComponent(0.54))
        let termsAndConditionsRange = (footerString as NSString).range(of: termsAndConditions)
        mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.workSansFont(ofSize: 14, weight: .medium), range: termsAndConditionsRange)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(hex: "0F5DFA"), range: termsAndConditionsRange)
        
        let privacyPolicyRange = (footerString as NSString).range(of: privacyPolicy)
        mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.workSansFont(ofSize: 14, weight: .medium), range: privacyPolicyRange)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(hex: "0F5DFA"), range: privacyPolicyRange)
        
        footerLabel.attributedText = mutableAttributedString
    }
}

// MARK: Handle actions
extension PasscodeViewController {
    
    @objc private func onPressedConfirm() {
        viewModel.loginWithPasscode(passcodeView.code).subscribe(on: MainScheduler.instance).subscribe(onNext: {
            Navigator.showRootTabbarController()
        }, onError: { error in
            debugPrint("ERROR")
        }).disposed(by: disposeBag)
    }
    
    @objc private func onPressedShowPasscode() {
        isPasscodeShowed = !isPasscodeShowed
    }
    
    @objc private func onTapFooterLabel(_ recognizer: UITapGestureRecognizer) {
        let termsAndConditionsRange = (footerString as NSString).range(of: termsAndConditions)
        let privacyPolicyRange = (footerString as NSString).range(of: privacyPolicy)

        if recognizer.didTapAttributedTextInLabel(label: footerLabel, inRange: termsAndConditionsRange) {
            
        } else if recognizer.didTapAttributedTextInLabel(label: footerLabel, inRange: privacyPolicyRange) {
            
        }
    }
}

