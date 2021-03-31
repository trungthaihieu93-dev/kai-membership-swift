//
//  UtilitiesViewController+DataSource.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 02/03/2021.
//

import UIKit

// MARK: UITableViewDataSource
extension UtilitiesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Section.allCases.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = Section(rawValue: indexPath.row) else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UtilitiesTableViewCell.identifier, for: indexPath) as! UtilitiesTableViewCell
        cell.delegate = self
        
        switch sectionType {
        case .mobileTopup:
            cell.configure(with: .mobileTopup)
        case .getVouchers:
            cell.configure(with: .getVouchers)
        case .kaiStarter:
            cell.configure(with: .kaiStarter)
        }
        
        return cell
    }
}
