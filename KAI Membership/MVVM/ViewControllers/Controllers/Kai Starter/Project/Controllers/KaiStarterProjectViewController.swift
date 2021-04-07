//
//  KaiStarterProjectViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 05/04/2021.
//

import UIKit

class KaiStarterProjectViewController: BaseViewController {

    // MARK: Properties
    let viewModel = KaiStarterProjectViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Constants.backroundColorDefault
        tableView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(KaiStarterProjectTableViewCell.self, forCellReuseIdentifier: KaiStarterProjectTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    // MARK: Life cycle's
    init(with title: String) {
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchData()
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
    
    // MARK: Data fetching
    private func fetchData() {
        viewModel.createData()
        tableView.reloadData()
    }
}
