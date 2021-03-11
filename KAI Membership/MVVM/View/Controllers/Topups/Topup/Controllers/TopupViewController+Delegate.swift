//
//  TopupViewController+Delegate.swift
//  KAI Membership
//
//  Created by DAKiet on 11/03/2021.
//

import UIKit

// MARK: UITableViewDelegate
extension TopupViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionType = Section(rawValue: section), sectionType == .setting else { return nil }
        
        let View = UIView()
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.black.withAlphaComponent(0.87)
        label.font = .workSansFont(ofSize: 20, weight: .regular)
        label.text = "Topup Settings"
        View.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: View.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: View.leadingAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: View.bottomAnchor),
            label.trailingAnchor.constraint(equalTo: View.trailingAnchor, constant: -20)
        ])
        
        return View
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let sectionType = Section(rawValue: section), sectionType == .setting else { return 0 }
        
        return 56
    }
}
