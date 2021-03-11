//
//  TopupViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 04/03/2021.
//

import UIKit
import RxSwift

class TopupViewController: BaseViewController {

    // MARK: Properties
    enum Section: Int, CaseIterable {
        case info
        case setting
    }
    
    let viewModel = TopupViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .init(hex: "E5E5E5")
        tableView.contentInset = .init(top: 0, left: 0, bottom: safeAreaInsets.bottom, right: 0)
        tableView.register(CardCollapseTableViewCell.self, forCellReuseIdentifier: CardCollapseTableViewCell.identifier)
        tableView.register(TopupTableViewCell.self, forCellReuseIdentifier: TopupTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    override var navigationColorDefault: UIColor {
        return .init(hex: "E5E5E5")
    }
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Top-up"
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
