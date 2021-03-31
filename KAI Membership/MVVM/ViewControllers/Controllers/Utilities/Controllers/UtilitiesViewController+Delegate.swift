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
        Navigator.openSpin(from: self)
    }
    
    func kAIBarButtonItemViewDidSelecteProfile(_ kAIBarButtonItemView: KAIBarButtonItemView) {
        if AccountManagement.isLoggedIn {
            Navigator.navigateToProfileVC(from: self)
        } else {
            Navigator.navigateToSignInVC(from: self) { [weak self] in
                guard let this = self else { return }
                
                kAIBarButtonItemView.refresh()
                Navigator.navigateToProfileVC(from: this)
            }
        }
    }
}

// MARK: UtilitiesTableViewCellDelegate
extension UtilitiesViewController: UtilitiesTableViewCellDelegate {
    
    func utilitiesTableViewCell(_ utilitiesTableViewCell: UtilitiesTableViewCell, didSelectEvent event: UtilitiesTableViewCell.`Type`) {
        switch event {
        case .mobileTopup:
            Navigator.navigateToTopupVC(from: self)
        case .getVouchers:
            break
        case .kaiStarter:
            Navigator.navigateToKaiStarterVC(from: self)
        }
    }
}
