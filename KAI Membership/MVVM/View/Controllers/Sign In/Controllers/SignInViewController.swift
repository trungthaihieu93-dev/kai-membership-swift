//
//  SignInViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 19/02/2021.
//

import UIKit
import RxSwift

class SignInViewController: BaseViewController {

    // MARK: Properties
    let viewModel = SignInViewModel()
    
    private lazy var trialButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setAttributedTitle(NSAttributedString(string: "Let me take a tour", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 16, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.87)
        ]), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.init(hex: "C9CED6").cgColor
        button.addTarget(self, action: #selector(onPressedTrail), for: .touchUpInside)
        
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var signInView: SignInView = {
        let view = SignInView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    override var pageTitle: String {
        return "Welcome!"
    }
    
    override var pageDiscription: String {
        return "Sign in and start our journey with KAI."
    }
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupView()
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTap(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTap)
    }
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(signInView)
        
        view.addSubview(trialButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: pageTitleView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            signInView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            signInView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            signInView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            signInView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            trialButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 8),
            trialButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            trialButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(safeAreaInsets.bottom + 24)),
            trialButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            trialButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    
    // MARK: Login
    func login() {
        guard let email = viewModel.email, !email.isEmpty, let password = viewModel.password, !password.isEmpty else {
            return
        }
        
        viewModel.login(with: email, and: password).subscribe(on: MainScheduler.instance).subscribe(onNext: { [weak self] login in
            guard let this = self else { return }
            
            // get info user
            Navigator.showRootTabbarController()
        }, onError: { error in
            debugPrint("Login error: \((error as? APIErrorResult)?.message ?? "ERROR")")
        }).disposed(by: disposeBag)
    }
}

// MARK: Handle actions
extension SignInViewController {
    
    @objc private func handleKeyboardNotification(_ notification: NSNotification) {
        if notification.name == UIResponder.keyboardWillShowNotification {
            guard let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            let bottomOffset = Constants.Device.screenSize.height - (scrollView.frame.origin.y + signInView.frame.origin.y + signInView.frame.height + 10)
            
            if keyboardFrame.height > bottomOffset {
                self.scrollView.setContentOffset(CGPoint(x: 0, y: keyboardFrame.height - bottomOffset), animated: true)
            }
        } else {
            self.scrollView.setContentOffset(.zero, animated: true)
        }
    }
    
    @objc private func onPressedTrail() {
        Navigator.showRootTabbarController()
    }
    
    @objc private func handleSingleTap(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
