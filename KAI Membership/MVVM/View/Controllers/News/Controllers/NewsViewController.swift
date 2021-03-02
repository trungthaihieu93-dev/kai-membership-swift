//
//  NewsViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import UIKit

class NewsViewController: BaseViewController {

    // MARK: Properties
    enum Section: Int, CaseIterable {
        case suggestion
        case lastest
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: 20, left: 0, bottom: 34, right: 0)
        tableView.register(SelectAccountTableViewCell.self, forCellReuseIdentifier: SelectAccountTableViewCell.identifier)
        tableView.dataSource = self
        
        return tableView
    }()
    
    override var pageTitle: String {
        return "Today News"
    }
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: pageTitleView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
