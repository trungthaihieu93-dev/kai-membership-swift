//
//  SelectAccountViewController+Delegate.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 01/03/2021.
//

import UIKit

// MARK: UITableViewDelegate
extension SelectAccountViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Navigator.navigateToPasscodeVC(from: self, with: .signIn)
    }
}
