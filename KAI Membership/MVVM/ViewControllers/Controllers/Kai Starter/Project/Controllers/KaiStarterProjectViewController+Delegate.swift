//
//  KaiStarterProjectViewController+Delegate.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 05/04/2021.
//

import UIKit

// MARK: UITableViewDelegate
extension KaiStarterProjectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KaiStarterProjectTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = viewModel.projects[indexPath.row].id, let title = viewModel.projects[indexPath.row].name else { return }
        
        Navigator.navigateToKaiStarterDetailVC(from: self, with: id, and: title)
    }
}
