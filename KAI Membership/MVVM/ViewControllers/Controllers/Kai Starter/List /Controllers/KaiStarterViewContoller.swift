//
//  KaiStarterViewContoller.swift
//  KAI Membership
//
//  Created by DAKiet on 31/03/2021.
//

import UIKit

class KaiStarterViewContoller: BaseViewController {

    // MARK: Properties
    enum ItemType: Int, CaseIterable {
        case ongoing
        case locking
        case completed
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Constants.backroundColorDefault
        tableView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(KaiStarterTableViewCell.self, forCellReuseIdentifier: KaiStarterTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "KAI Starter"
        
        setupView()
    }
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
