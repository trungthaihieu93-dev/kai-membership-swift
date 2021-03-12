//
//  ProfileViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 08/03/2021.
//

import UIKit

class ProfileViewController: BaseViewController {

    // MARK: Properties
    enum Section: Int, CaseIterable {
        case personal = 0
        case others
    }
    
    enum PersonalItem: Int, CaseIterable {
        case profile = 0
        case rewards
        case changePassword
    }
    
    enum OthersItem: Int, CaseIterable {
        case switchAccount = 0
        case signOut
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
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = UIColor.init(hex: "98A1B1")
        label.font = .workSansFont(ofSize: 10, weight: .medium)
        label.text = "KArdiachain © 2020 - Version \(Constants.appVersion)"
        
        return label
    }()
    
    private(set) lazy var headerView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        
        return view
    }()
    
    override var navigationAlphaDefault: CGFloat {
        return 0
    }
    
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
        view.addSubview(versionLabel)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            versionLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            versionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            versionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            versionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            versionLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupTableHeaderView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Constants.Device.screenBounds.width, height: 361))
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 337)
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
