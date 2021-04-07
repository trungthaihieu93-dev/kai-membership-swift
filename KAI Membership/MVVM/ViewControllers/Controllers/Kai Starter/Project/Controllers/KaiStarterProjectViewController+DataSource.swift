//
//  KaiStarterProjectViewController+DataSource.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 05/04/2021.
//

import UIKit

// MARK: UITableViewDataSource
extension KaiStarterProjectViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KaiStarterProjectTableViewCell.identifier, for: indexPath) as! KaiStarterProjectTableViewCell
        cell.configure(with: viewModel.projects[indexPath.row])
        
        return cell
    }
}
