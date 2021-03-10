//
//  NewPasswordViewController+Delegate.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 08/03/2021.
//

import UIKit

extension NewPasswordViewController: KAITextFieldViewDelegate {
    
    func kAITextFieldViewDidChange(_ textField: UITextField, for view: UIView) {
        isConfirmEnabled = (inputPasswordView.contentInput.count >= Constants.lengthPasswordMinimum) && !inputTokenView.contentInput.isEmpty && (confirmPasswordView.contentInput.count >= Constants.lengthPasswordMinimum)
    }
    
    func kAITextFieldViewShouldReturn(_ textField: UITextField, for view: UIView) -> Bool {
        return false
    }
    
    func kAITextFieldViewShouldClear(_ textField: UITextField, for view: UIView) -> Bool {
        return true
    }
}
