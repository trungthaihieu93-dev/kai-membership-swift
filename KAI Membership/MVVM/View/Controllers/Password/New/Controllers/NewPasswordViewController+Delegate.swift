//
//  NewPasswordViewController+Delegate.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 08/03/2021.
//

import UIKit

extension NewPasswordViewController: KAITextFieldViewDelegate {
    
    func kAITextFieldViewDidBeginEditing(_ textField: UITextField, for view: UIView) {
        
    }
    
    func kAITextFieldViewDidEndEditing(_ textField: UITextField, for view: UIView) {
        
    }
    
    func kAITextFieldViewDidChange(_ textField: UITextField, for view: UIView) {
        
    }
    
    func kAITextFieldViewShouldReturn(_ textField: UITextField, for view: UIView) -> Bool {
        return false
    }
    
    func kAITextFieldViewShouldClear(_ textField: UITextField, for view: UIView) -> Bool {
        return true
    }
}
