//
//  SignUpViewController+Delegate.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 07/03/2021.
//

import UIKit

extension SignUpViewController: SignUpInputViewDelegate {
    
    func signUpInputViewEmailValueChange(_ signUpInputView: SignUpInputView, textField: UITextField) {
        viewModel.updateEmail(textField.text)
    }
    
    func signUpInputViewPasswordValueChange(_ signUpInputView: SignUpInputView, textField: UITextField) {
        viewModel.updatePassword(textField.text)
    }
    
    func signUpInputViewConfirmPasswordValueChange(_ signUpInputView: SignUpInputView, textField: UITextField) {
        viewModel.confirmPassword(textField.text)
    }
    
    func signUpInputViewDidFinishTouchingAction(_ signUpInputView: SignUpInputView, actionKey: SignUpInputView.ActionKey) {
        switch actionKey {
        case .signIn:
            Navigator.navigateToSignUpVC(from: self)
        case .createAccount:
            createAccount()
        }
    }
}
