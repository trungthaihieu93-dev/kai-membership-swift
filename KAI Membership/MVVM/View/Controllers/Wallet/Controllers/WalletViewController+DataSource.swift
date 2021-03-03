//
//  WalletViewController+DataSource.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 02/03/2021.
//

import UIKit

// MARK: UITableViewDataSource
extension WalletViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.transactions.count > 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentTransactionsTableViewCell.identifier, for: indexPath) as! RecentTransactionsTableViewCell
        cell.configure(with: viewModel.transactions[indexPath.row])
        
        return cell
    }
}
