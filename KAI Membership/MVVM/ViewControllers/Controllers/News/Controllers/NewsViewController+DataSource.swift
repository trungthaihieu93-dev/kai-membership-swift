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
        guard let sectionType = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch sectionType {
        case .suggestion:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsSuggestionTableViewCell.identifier, for: indexPath) as! NewsSuggestionTableViewCell
            cell.reloadWithData(viewModel.suggestions)
            cell.didSelectDirectLinking = {
                Helper.openSafari($0)
//                Navigator.navigateToWebKitVC(from: self, url: $0, iSafeAreaLayout: true)
            }
            
            return cell
        case .lastest:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsLastestTableViewCell.identifier, for: indexPath) as! NewsLastestTableViewCell
            cell.reloadWithData(viewModel.lastests)
            cell.didSelectDirectLinking = {
//                Navigator.navigateToWebKitVC(from: self, url: $0, iSafeAreaLayout: true)
                Helper.openSafari($0)
            }
            
            return cell
        }
    }
}
