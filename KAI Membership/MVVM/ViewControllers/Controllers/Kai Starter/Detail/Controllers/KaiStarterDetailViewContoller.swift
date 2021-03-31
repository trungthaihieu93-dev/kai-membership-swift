//
//  KaiStarterDetailViewContoller.swift
//  KAI Membership
//
//  Created by DAKiet on 31/03/2021.
//

import UIKit

class KaiStarterDetailViewContoller: BaseViewController {

    // MARK: Properties
    let viewModel: KaiStarterDetailViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.rowHeight = 340
        tableView.backgroundColor = Constants.backroundColorDefault
        tableView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(KaiStarterTableViewCell.self, forCellReuseIdentifier: KaiStarterTableViewCell.identifier)
        tableView.dataSource = self
//        tableView.delegate = self
        
        return tableView
    }()
    
    // MARK: Life cycle's
    init(with id: String, and title: String) {
        self.viewModel = KaiStarterDetailViewModel(with: id)
        
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
