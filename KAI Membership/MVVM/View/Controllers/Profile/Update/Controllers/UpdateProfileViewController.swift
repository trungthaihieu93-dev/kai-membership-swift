//
//  UpdateProfileViewController.swift
//  KAI Membership
//
//  Created by DAKiet on 10/03/2021.
//

import UIKit
import RxSwift

class UpdateProfileViewController: BaseViewController2 {
    
    // MARK: Properties
    let viewModel = UpdateProfileViewModel()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        
        return scrollView
    }()
    
    private lazy var inputFullNameView: KAIInputTextFieldView = {
        let view = KAIInputTextFieldView(with: .default, title: "FULL NAME", placeholder: "Full Name")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    private lazy var inputDOBView: KAIInputTextFieldView = {
        let view = KAIInputTextFieldView(with: .default, title: "DATE OF BIRTH", placeholder: "01/01/1988")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    private lazy var inputPhoneNumberView: KAIInputTextFieldView = {
        let view = KAIInputTextFieldView(with: .default, title: "PHONE NO.", placeholder: "e.g 0903509786")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    private lazy var updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(NSAttributedString(string: "Update Profile", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 16, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]), for: .normal)
        button.isEnabled = false
        button.backgroundColor = .init(hex: "E1E4E8")
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(onPressedUpdateProfile), for: .touchUpInside)
        
        return button
    }()
    
    private var updateButtonBottomAnchor: NSLayoutConstraint?
    
    var isConfirmEnabled: Bool = false {
        didSet {
            guard isConfirmEnabled != oldValue else { return }
            
            updateButton.isEnabled = isConfirmEnabled
            
            if isConfirmEnabled {
                updateButton.gradientBackgroundColors([UIColor.init(hex: "394656").cgColor, UIColor.init(hex: "181E25").cgColor], direction: .vertical)
            } else {
                updateButton.removeAllSublayers(withName: UIView.gradientLayerKey)
            }
        }
    }
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "My Profile"
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
        view.addSubview(scrollView)
        view.addSubview(updateButton)
        
        scrollView.addSubview(inputFullNameView)
        scrollView.addSubview(inputDOBView)
        scrollView.addSubview(inputPhoneNumberView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            updateButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 8),
            updateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            updateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            updateButton.heightAnchor.constraint(equalToConstant: 52),
            
            inputFullNameView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            inputFullNameView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            inputFullNameView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            inputFullNameView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            
            inputDOBView.topAnchor.constraint(equalTo: inputFullNameView.bottomAnchor, constant: 12),
            inputDOBView.leadingAnchor.constraint(equalTo: inputFullNameView.leadingAnchor),
            inputDOBView.trailingAnchor.constraint(equalTo: inputFullNameView.trailingAnchor),
            
            inputPhoneNumberView.topAnchor.constraint(equalTo: inputDOBView.bottomAnchor, constant: 12),
            inputPhoneNumberView.leadingAnchor.constraint(equalTo: inputFullNameView.leadingAnchor),
            inputPhoneNumberView.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor),
            inputPhoneNumberView.trailingAnchor.constraint(equalTo: inputFullNameView.trailingAnchor),
        ])
        
        updateButtonBottomAnchor = updateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(safeAreaInsets.bottom + 20))
        updateButtonBottomAnchor?.isActive = true
    }
}

// MARK: Handle actions
extension UpdateProfileViewController {
    
    @objc private func handleKeyboardNotification(_ notification: NSNotification) {
        if notification.name == UIResponder.keyboardWillShowNotification {
            guard let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            updateButtonBottomAnchor?.constant = -(keyboardFrame.height + 20)
        } else {
            updateButtonBottomAnchor?.constant = -(safeAreaInsets.bottom + 20)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func onPressedUpdateProfile() {
        
    }
    
    @objc private func handleSingleTap(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
