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
        cell.collectionView.tag = indexPath.row
        cell.delegate = self
        
        switch itemType {
        case .ongoing:
            cell.contentTitle = "Ongoing Projects"
            cell.reloadWithData(viewModel.ongoingProjects)
        case .locking:
            cell.contentTitle = "Locking Projects"
            cell.reloadWithData(viewModel.lockingProjects)
        case .completed:
            cell.contentTitle = "Completed Projects"
            cell.reloadWithData(viewModel.completedProjects)
        }
        
        return cell
    }
}
