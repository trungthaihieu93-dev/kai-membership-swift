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
    
    private let loaderView: QuestSkeletonView = {
        let view = QuestSkeletonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.backgroundColor = Constants.backroundColorDefault
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 12))
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.identifier)
        tableView.register(QuestTableViewCell.self, forCellReuseIdentifier: QuestTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private var isHiddenLoader: Bool = false {
        didSet {
            loaderView.removeFromSuperview()
        }
    }
    
    var didFinishTouchingInviteFriend: (() -> Void)?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        if !isHiddenLoader {
            view.addSubview(loaderView)
            
            NSLayoutConstraint.activate([
                loaderView.topAnchor.constraint(equalTo: view.topAnchor),
                loaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                loaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                loaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    }
    
    // MARK: Configure
    func configure(_ quests: [QuestRemote]) {
        self.quests = quests
        tableView.reloadData()
        isHiddenLoader = true
    }
}
