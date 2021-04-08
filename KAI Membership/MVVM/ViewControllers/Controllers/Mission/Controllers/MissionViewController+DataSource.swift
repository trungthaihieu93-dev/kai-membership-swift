//
//  MissionViewController+DataSource.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 07/04/2021.
//

import UIKit
import DZNEmptyDataSet

// MARK: DZNEmptyDataSetSource
extension MissionViewController: DZNEmptyDataSetSource {
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "image_wallet_empty")!
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "No Misson", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 20, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.87)
        ])
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return MissionHeaderView.height / 2
    }
}

// MARK: UITableViewDataSource
extension MissionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.quests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MissionTableViewCell.identifier, for: indexPath) as! MissionTableViewCell
        cell.configure(viewModel.quests[indexPath.row])
        
        return cell
    }
}
