//
//  MissionViewController+Delegate.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 07/04/2021.
//

import UIKit
import DZNEmptyDataSet
import StoreKit

// MARK: DZNEmptyDataSetDelegate
extension MissionViewController: DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}

// MARK: KAIBarButtonItemViewDelegate
extension MissionViewController: KAIBarButtonItemViewDelegate {
    
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

// MARK: UITableViewDelegate
extension MissionViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = scrollView.contentOffset.y
        
        if y <= 0 {
//            headerView.frame.size.height = 300 + y
//            navigationBarAnimation(withAlpha: 0)
            headerView.zoomImage(with: y)
        } else {
//            let headerHeight: CGFloat = headerView.originalHeaderHeight
//            let tmp = y / headerHeight
//            let alpha = y > headerHeight || tmp >= 1 ? 1 : tmp
//            navigationBarAnimation(withAlpha: alpha)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard AccountManagement.accessToken != nil else { return }
        
        switch viewModel.quests[indexPath.row].key {
        case .highestScores, .thiryMinutes, .signIn:
            break
        case .inviteFriend:
            let items = [AccountManagement.accountInfo?.user?.refarralAppflyerLink ?? ""]
            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
            present(ac, animated: true)
        case .sendKai:
            Navigator.navigateToSendVC(from: self)
        case .rateApp:
            checkMissionCompleted(with: .rateApp)
            SKStoreReviewController.requestReview()
        case .verifyEmail:
            checkMissionCompleted(with: .verifyEmail)
        case .followTwitter:
            checkMissionCompleted(with: .followTwitter)
            Helper.openSafari(AppSetting.twitterLink)
        case .likeFacebook:
            checkMissionCompleted(with: .likeFacebook)
            Helper.openSafari(AppSetting.facebookLink)
        case .joinTelegram:
            checkMissionCompleted(with: .joinTelegram)
            Helper.openSafari(AppSetting.telegramLink)
        }
    }
}
