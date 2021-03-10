//
//  ForgotPasswordViewController+Delegate.swift
//  KAI Membership
//
//  Created by DAKiet on 10/03/2021.
//

import UIKit

// MARK: KAITextFieldViewDelegate
extension ForgotPasswordViewController: KAITextFieldViewDelegate {
    
    func kAITextFieldViewDidChange(_ textField: UITextField, for view: UIView) {
        isConfirmEnabled = !(textField.text ?? "").isEmpty
    }
    
    func kAITextFieldViewShouldReturn(_ textField: UITextField, for view: UIView) -> Bool {
        return false
    }
    
    func kAITextFieldViewShouldClear(_ textField: UITextField, for view: UIView) -> Bool {
        return true
    }
}
