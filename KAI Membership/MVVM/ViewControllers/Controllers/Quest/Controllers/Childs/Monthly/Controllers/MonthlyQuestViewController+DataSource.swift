//
//  MonthlyQuestViewController+DataSource.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 05/03/2021.
//

import UIKit

// MARK: UITableViewDataSource
extension MonthlyQuestViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quests.count > 0 ? quests.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if quests.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: QuestTableViewCell.identifier, for: indexPath) as! QuestTableViewCell
            cell.configure(quests[indexPath.row])
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.identifier, for: indexPath) as! EmptyTableViewCell
            cell.configure(image: UIImage(named: "image_wallet_empty"), title: "No Misson")
            
            return cell
        }
    }
}
