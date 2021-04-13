//
//  KaiStarterDetailViewContoller+DataSource.swift
//  KAI Membership
//
//  Created by DAKiet on 31/03/2021.
//

import UIKit

// MARK: UITableViewDataSource
extension KaiStarterDetailViewContoller: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = SectionType(rawValue: section) else { return 0 }
        
        switch sectionType {
        case .title:
            return TitleItemType.allCases.count
        case .description:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = SectionType(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch sectionType {
        case .title:
            guard let itemType = TitleItemType(rawValue: indexPath.row) else { return UITableViewCell() }
            
            switch itemType {
            case .media:
                let cell = tableView.dequeueReusableCell(withIdentifier: ManufacturerTableViewCell.identifier, for: indexPath) as! ManufacturerTableViewCell
                cell.configure(imageLink: nil, name: "Media", description: "436a/73 Duong 3 Thang 2 Str., W.12, District 10, Ho Chi Minh City")
                
                return cell
            case .manufacturer:
                let cell = tableView.dequeueReusableCell(withIdentifier: ManufacturerTableViewCell.identifier, for: indexPath) as! ManufacturerTableViewCell
                cell.configure(imageLink: nil, name: "BigCat Entertainment Co.,Ltd", description: "436a/73 Duong 3 Thang 2 Str., W.12, District 10, Ho Chi Minh City")
                
                return cell
            }
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: KaiStarterDetailDescriptionTableViewCell.identifier, for: indexPath) as! KaiStarterDetailDescriptionTableViewCell
            cell.configure(title: "Lock & Earn Policy")
            
            return cell
        }
    }
}
