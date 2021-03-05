//
//  WalletViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import UIKit
import DZNEmptyDataSet
import RxSwift

class WalletViewController: BaseViewController {

    // MARK: Properties
    let viewModel = WalletViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: 0, left: 0, bottom: 34, right: 0)
        tableView.register(RecentTransactionsTableViewCell.self, forCellReuseIdentifier: RecentTransactionsTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        return tableView
    }()
    
    private let cardView = CardView()
    
    override var pageTitle: String {
        return "My Wallet"
    }
    
    override var isHiddenNavigationBar: Bool {
        return false
    }
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableHeaderView()
        fetchData()
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
    
    private func setupTableHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.Device.screenSize.width, height: 252))
        cardView.frame = CGRect(x: 30, y: 25, width: headerView.frame.width - 60, height: headerView.frame.height - 50)
        headerView.addSubview(cardView)
        cardView.configure(kai: 3002.123, walletAddress: "0x9e991abd0...0e7927dd4b3d58", holder: "AN NGUYEN", memberSince: 1598522428)
        
        tableView.tableHeaderView = headerView
    }
}

// MARK: Data fetching
extension WalletViewController {
    
    private func fetchData() {
        viewModel.getTransactions().subscribe(on: MainScheduler.instance).subscribe(onNext: { [weak self] transactions in
            guard let this = self else { return }
            
            this.tableView.reloadData()
        } , onError: { error in
            debugPrint("")
        } , onCompleted: { [weak self] in
            guard let this = self else { return }
            
        }).disposed(by: disposeBag)
    }
}
