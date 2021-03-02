//
//  WalletViewController+Delegate.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 02/03/2021.
//

import UIKit
import DZNEmptyDataSet

// MARK: UITableViewDelegate
extension WalletViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

// MARK: DZNEmptyDataSetSource
extension WalletViewController: DZNEmptyDataSetSource {
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "image_wallet_empty")!
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "No Transaction", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 20, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.87)
        ])
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Start your first transaction", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 14, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.54)
        ])
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 100
    }
}
