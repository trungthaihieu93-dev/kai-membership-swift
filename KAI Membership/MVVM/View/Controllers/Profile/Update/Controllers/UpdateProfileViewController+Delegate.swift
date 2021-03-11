//
//  UpdateProfileViewController+Delegate.swift
//  KAI Membership
//
//  Created by DAKiet on 10/03/2021.
//

import UIKit

// MARK: KAITextFieldDelegate
extension UpdateProfileViewController: KAITextFieldDelegate {
    
    func kAITextFieldDidChange(_ textField: UITextField, for view: UIView) {
        
    }
    
    func kAITextFieldShouldReturn(_ textField: UITextField, for view: UIView) -> Bool {
        return false
    }
    
    func kAITextFieldShouldClear(_ textField: UITextField, for view: UIView) -> Bool {
        return true
    }
}

