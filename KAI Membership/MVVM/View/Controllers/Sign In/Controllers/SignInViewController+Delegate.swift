//
//  SignInViewController+Delegate.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 01/03/2021.
//

import UIKit

extension SignInViewController: SignInInputViewDelegate {
    
    func signInInputViewEmailValueChange(_ signInInputView: SignInInputView, textField: UITextField) {
        viewModel.updateEmail(textField.text)
    }
    
    func signInInputViewPasswordValueChange(_ signInInputView: SignInInputView, textField: UITextField) {
        viewModel.updatePassword(textField.text)
    }
    
    func signInInputViewDidFinishTouchingAction(_ signInInputView: SignInInputView, actionKey: SignInInputView.ActionKey) {
        switch actionKey {
        case.forgotPassword:
            Navigator.navigateToForgotPasswordVC(from: self)
        case .signIn:
            login()
        case .createAccount:
            Navigator.navigateToSignUpVC(from: self)
        }
    }
}
