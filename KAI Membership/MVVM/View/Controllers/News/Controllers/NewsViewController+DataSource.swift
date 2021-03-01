//
//  NewsViewController+DataSource.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 01/03/2021.
//

import UIKit

// MARK: UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectAccountTableViewCell.identifier, for: indexPath) as! SelectAccountTableViewCell
        
        return cell
    }
}
