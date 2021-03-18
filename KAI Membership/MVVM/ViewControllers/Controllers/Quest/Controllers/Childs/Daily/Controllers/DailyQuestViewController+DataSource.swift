//
//  DailyQuestViewController+DataSource.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 05/03/2021.
//

import UIKit
import DZNEmptyDataSet

// MARK: DZNEmptyDataSetSource
extension DailyQuestViewController: DZNEmptyDataSetSource {
    
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
        return 0
    }
}

// MARK: UITableViewDataSource
extension DailyQuestViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestTableViewCell.identifier, for: indexPath) as! QuestTableViewCell
//        cell.configure(with: indexPath.row == 0 ? .inProgress : .completed, title: "Spend 30 minutes in Games", description: "Completed")
        cell.configure(quests[indexPath.row])
        
        return cell
    }
}
