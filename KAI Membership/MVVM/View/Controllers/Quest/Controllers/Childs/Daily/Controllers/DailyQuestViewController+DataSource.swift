//
//  DailyQuestViewController+DataSource.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 05/03/2021.
//

import UIKit

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
