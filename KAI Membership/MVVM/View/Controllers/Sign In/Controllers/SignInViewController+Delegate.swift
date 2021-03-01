//
//  SignInViewController+Delegate.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 01/03/2021.
//

import UIKit

extension SignInViewController: SignInViewDelegate {
    
    func signInViewEmailValueChange(_ signInView: SignInView, textField: UITextField) {
        viewModel.updateEmail(textField.text)
    }
    
    func signInViewPasswordValueChange(_ signInView: SignInView, textField: UITextField) {
        viewModel.updatePassword(textField.text)
    }
    
    func signInViewDidFinishTouchingAction(_ signInView: SignInView, actionKey: SignInView.ActionKey) {
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
