//
//  SignUpViewController+Delegate.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 07/03/2021.
//

import UIKit

extension SignUpViewController: SignUpViewDelegate {
    
    func signUpViewEmailValueChange(_ signUpView: SignUpView, textField: UITextField) {
        viewModel.updateEmail(textField.text)
    }
    
    func signUpViewPasswordValueChange(_ signUpView: SignUpView, textField: UITextField) {
        viewModel.updatePassword(textField.text)
    }
    
    func signUpViewConfirmPasswordValueChange(_ signUpView: SignUpView, textField: UITextField) {
        viewModel.confirmPassword(textField.text)
    }
    
    func signUpViewDidFinishTouchingAction(_ signUpView: SignUpView, actionKey: SignUpView.ActionKey) {
        switch actionKey {
        case .signIn:
            Navigator.navigateToSignUpVC(from: self)
        case .createAccount:
            createAccount()
        }
    }
}
