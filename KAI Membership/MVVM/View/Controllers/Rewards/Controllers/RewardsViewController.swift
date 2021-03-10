//
//  RewardsViewController.swift
//  KAI Membership
//
//  Created by DAKiet on 10/03/2021.
//

import UIKit
import RxSwift
import DZNEmptyDataSet

class RewardsViewController: BaseViewController2 {

    // MARK: Properties
    enum Section: Int, CaseIterable {
        case rewards
        case history
    }
    
    private(set) lazy var emptyView: RewardsEmptyView = {
        let view = RewardsEmptyView()
        view.didFinishTouchingGoToMission = { [weak self] in
            guard let this = self else { return }
            
            Navigator.navigateToQuestVC(from: this)
        }
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: 0, left: 0, bottom: safeAreaInsets.bottom, right: 0)
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        return tableView
    }()
    
    private(set) lazy var headerView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        
        return view
    }()
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My reward"
        setupView()
        fetchData()
    }
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: Data fetching
    func fetchData() {
        tableView.reloadData()
    }
}
