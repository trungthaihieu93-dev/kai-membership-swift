//
//  ProfileViewController+Delegate.swift
//  KAI Membership
//
//  Created by DAKiet on 09/03/2021.
//

import UIKit

// MARK: UIScrollViewDelegate
extension ProfileViewController {
    
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
}

// MARK: UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionType = Section(rawValue: section) else { return nil }
        
        let footerView = UIView()
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.black.withAlphaComponent(0.87)
        label.font = .workSansFont(ofSize: 20, weight: .regular)
        
        switch sectionType {
        case .personal:
            label.text = "Personal"
        case .others:
            label.text = "Others"
        }
        
        footerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: footerView.topAnchor),
            label.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: footerView.bottomAnchor),
            label.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20)
        ])
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sectionType = Section(rawValue: indexPath.section) else { return }
        
        switch sectionType {
        case .personal:
            guard let itemType = PersonalItem(rawValue: indexPath.row) else { return }
            
            switch itemType {
            case .profile:
                Navigator.navigateToUpdateProfileVC(from: self)
            case .rewards:
                Navigator.navigateToRewardsVC(from: self)
            case .changePassword:
                Navigator.navigateToPasscodeVC(from: self, with: .changePassword, email: AccountManagement.email ?? "")
            }
        case .others:
            guard let itemType = OthersItem(rawValue: indexPath.row) else { return }
            
            switch itemType {
            case .switchAccount:
                debugPrint("")
            case .signOut:
                debugPrint("")
            }
        }
    }
}
