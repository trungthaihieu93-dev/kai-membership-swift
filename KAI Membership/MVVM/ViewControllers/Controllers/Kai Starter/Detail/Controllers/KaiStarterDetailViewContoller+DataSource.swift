//
//  KaiStarterDetailViewContoller+DataSource.swift
//  KAI Membership
//
//  Created by DAKiet on 31/03/2021.
//

import UIKit

// MARK: UITableViewDataSource
extension KaiStarterDetailViewContoller: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KaiStarterTableViewCell.identifier, for: indexPath) as! KaiStarterTableViewCell
        cell.contentTitle = "Ongoing Projects"
        
        return cell
    }
}
