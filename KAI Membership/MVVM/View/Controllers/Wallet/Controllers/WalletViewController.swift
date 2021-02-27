//
//  WalletViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import UIKit
import DZNEmptyDataSet

class WalletViewController: BaseViewController {

    // MARK: Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: 10, left: 0, bottom: 34, right: 0)
        tableView.register(SelectAccountTableViewCell.self, forCellReuseIdentifier: SelectAccountTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.emptyDataSetSource = self
        
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
//        tableView.tableHeaderView = cardView
        setupTableHeaderView()
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
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.Device.screenSize.width, height: 200))
        cardView.frame = CGRect(x: 31, y: 0, width: headerView.frame.width - 62, height: headerView.frame.height)
        headerView.addSubview(cardView)
        cardView.configure(kai: 3002.123, walletAddress: "0x9e991abd0...0e7927dd4b3d58", holder: "AN NGUYEN", memberSince: 1598522428)
        
        tableView.tableHeaderView = headerView
    }
}

// MARK: UITableViewDataSource
extension WalletViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectAccountTableViewCell.identifier, for: indexPath) as! SelectAccountTableViewCell
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension WalletViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Navigator.navigateToPasscodeVC(from: self, with: .signIn)
    }
}

// MARK: DZNEmptyDataSetSource
extension WalletViewController: DZNEmptyDataSetSource {
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "placeholder_wallet_emptydata")!
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "No Transaction", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 20, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.87)
        ])
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Start your first transaction", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 14, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.54)
        ])
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 100
    }
}
