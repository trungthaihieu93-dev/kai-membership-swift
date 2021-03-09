//
//  UtilitiesViewController+Delegate.swift
//  KAI Membership
//
//  Created by DAKiet on 09/03/2021.
//

import UIKit

// MARK: KAIBarButtonItemViewDelegate
extension UtilitiesViewController: KAIBarButtonItemViewDelegate {
    
    func kAIBarButtonItemViewDidSelecteSpin(_ kAIBarButtonItemView: KAIBarButtonItemView) {
        // Web view
    }
    
    func kAIBarButtonItemViewDidSelecteProfile(_ kAIBarButtonItemView: KAIBarButtonItemView) {
        Navigator.navigateToProfileVC(from: self)
    }
}
