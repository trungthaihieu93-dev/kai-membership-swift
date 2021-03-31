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
            debugPrint("")
        case .locking:
            debugPrint("")
        case .completed:
            debugPrint("")
        }
    }
    
    func kaiStarterTableViewCell(_ kaiStarterTableViewCell: KaiStarterTableViewCell, didSelectItemAt indexPath: IndexPath) {
        guard let itemType = ItemType(rawValue: kaiStarterTableViewCell.collectionView.tag) else { return }
        
        switch itemType {
        case .ongoing:
            debugPrint("")
        case .locking:
            debugPrint("")
        case .completed:
            debugPrint("")
        }
    }
}
