//
//  SelectAccountViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import UIKit
import RxSwift

class SelectAccountViewController: BaseViewController {

    // MARK: Properties
    let users: [UserRemote]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0.01, height: 0.01))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0.01, height: 0.01))
        tableView.backgroundColor = Constants.backroundColorDefault
        tableView.contentInset = .init(top: 0, left: 0, bottom: safeAreaInsets.bottom, right: 0)
        tableView.register(SelectAccountTableViewCell.self, forCellReuseIdentifier: SelectAccountTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    init(with users: [UserRemote]) {
        self.users = users
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Select Account"
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
    
    // MARK: Handle actions
    @objc func onPressedSignInAnotherAccount() {
        Navigator.navigateToSignInVC(from:  self)
    }
}
