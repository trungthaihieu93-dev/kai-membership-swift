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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footerView = UIView()
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.attributedText = NSAttributedString(string: "Recent Transactions", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 20, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.87)
        ])
        footerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: footerView.topAnchor),
            label.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: footerView.bottomAnchor),
            label.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20)
        ])
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentTransactionsTableViewCell.identifier, for: indexPath) as! RecentTransactionsTableViewCell
        cell.configure(with: viewModel.transactions[indexPath.row])
        
        return cell
    }
}
