//
//  SignUpViewController+Delegate.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 07/03/2021.
//

import UIKit

extension SignUpViewController: SignUpInputViewDelegate {
    
    func signUpInputViewDidFinishTouchingAction(_ signUpInputView: SignUpInputView, actionKey: SignUpInputView.ActionKey) {
        switch actionKey {
        case .signIn:
//            navigationController?.viewControllers.removeAll { return $0 is SignInViewController }
            Navigator.navigateToSignInVC(from: self)
        case .createAccount:
            createAccount()
        }
    }
}
