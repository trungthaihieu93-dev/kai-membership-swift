//
//  ProfileViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 08/03/2021.
//

import UIKit

class ProfileViewController: BaseViewController2 {

    // MARK: Properties
    enum Section: Int, CaseIterable {
        case personal = 0
        case others
    }
    
    private lazy var cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame.size = CGSize(width: 32, height: 32)
        button.setImage(UIImage(named: "ic_camera")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.createShadow(radius: 8)
        button.addTarget(self, action: #selector(onPressedCamera), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: 0, left: 0, bottom: safeAreaInsets.bottom, right: 0)
        tableView.register(NewsSuggestionTableViewCell.self, forCellReuseIdentifier: NewsSuggestionTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private(set) lazy var headerView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        
        return view
    }()
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.setRightBarButton(UIBarButtonItem(customView: cameraButton), animated: true)
        setupView()
        setupTableHeaderView()
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
    
    private func setupTableHeaderView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Constants.Device.screenSize.width, height: 252))
//        headerView.frame = CGRect(x: 30, y: 25, width: headerView.frame.width - 60, height: headerView.frame.height - 50)
        view.addSubview(headerView)
        
        tableView.tableHeaderView = view
    }
    
    // MARK: Data fetching
    func fetchData() {
        tableView.reloadData()
    }
    
    // MARK: Handle actions
    @objc private func onPressedCamera() {
        
    }
}
