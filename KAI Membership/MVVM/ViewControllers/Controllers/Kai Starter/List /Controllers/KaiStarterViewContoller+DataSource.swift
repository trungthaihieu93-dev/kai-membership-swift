//
//  KaiStarterViewContoller+DataSource.swift
//  KAI Membership
//
//  Created by DAKiet on 31/03/2021.
//

import UIKit

// MARK: UITableViewDataSource
extension KaiStarterViewContoller: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemType = ItemType(rawValue: indexPath.row) else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KaiStarterTableViewCell.identifier, for: indexPath) as! KaiStarterTableViewCell
        
        switch itemType {
        case .ongoing:
            cell.contentTitle = "Ongoing Projects"
        case .locking:
            cell.contentTitle = "Locking Projects"
        case .completed:
            cell.contentTitle = "Completed Projects"
        }
        
        return cell
    }
}
