//
//  KaiStarterViewContoller+Delegate.swift
//  KAI Membership
//
//  Created by DAKiet on 31/03/2021.
//

import UIKit

// MARK: UITableViewDelegate
extension KaiStarterViewContoller: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KaiStarterCollectionViewCell.height + 40
    }
}

// MARK: KaiStarterTableViewCellDelegate
extension KaiStarterViewContoller: KaiStarterTableViewCellDelegate {
    
    func kaiStarterTableViewCellDidSelectViewAll(_ kaiStarterTableViewCell: KaiStarterTableViewCell) {
        guard let itemType = ItemType(rawValue: kaiStarterTableViewCell.collectionView.tag) else { return }
        
        switch itemType {
        case .ongoing:
            Navigator.navigateToKaiStarterProjectVC(from: self, with: "Ongoing Projects")
        case .locking:
            Navigator.navigateToKaiStarterProjectVC(from: self, with: "Locking Projects")
        case .completed:
            Navigator.navigateToKaiStarterProjectVC(from: self, with: "Completed Projects")
        }
    }
    
    func kaiStarterTableViewCell(_ kaiStarterTableViewCell: KaiStarterTableViewCell, didSelectItemAt indexPath: IndexPath) {
        guard let itemType = ItemType(rawValue: kaiStarterTableViewCell.collectionView.tag) else { return }
        
        switch itemType {
        case .ongoing:
            Navigator.navigateToKaiStarterDetailVC(from: self, with: "", and: "Sugar Baby \(indexPath.row)")
        case .locking:
            Navigator.navigateToKaiStarterDetailVC(from: self, with: "", and: "Locking Sugar Baby \(indexPath.row)")
        case .completed:
            Navigator.navigateToKaiStarterDetailVC(from: self, with: "", and: "Futsal Prize Farming \(indexPath.row)")
        }
    }
}
