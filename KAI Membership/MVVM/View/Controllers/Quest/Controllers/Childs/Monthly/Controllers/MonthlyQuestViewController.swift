//
//  MonthlyQuestViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 05/03/2021.
//

import UIKit

class MonthlyQuestViewController: UIViewController {

    // MARK: Properties
    private(set) var quests = [QuestRemote]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .init(hex: "F7F8F9")
        tableView.contentInset = .init(top: 6, left: 0, bottom: 0, right: 0)
        tableView.register(QuestTableViewCell.self, forCellReuseIdentifier: QuestTableViewCell.identifier)
        tableView.dataSource = self
        
        return tableView
    }()
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: Configure
    func configure(_ quests: [QuestRemote]) {
        self.quests = quests
        tableView.reloadData()
    }
}
