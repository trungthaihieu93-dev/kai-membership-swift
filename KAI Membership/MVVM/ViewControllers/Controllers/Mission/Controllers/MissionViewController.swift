//
//  MissionViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 07/04/2021.
//

import UIKit
import RxSwift
import DZNEmptyDataSet

class MissionViewController: BaseViewController {
    
    // MARK: Properties
    let viewModel = MissionViewModel()
    
    private lazy var rightBarButtonItemView: KAIBarButtonItemView = {
        let view = KAIBarButtonItemView()
        view.delegate = self
        
        return view
    }()
    
    private(set) lazy var headerView: MissionHeaderView = {
        let view = MissionHeaderView()
        
        return view
    }()
    
    private let loaderView: MissionSkeletonView = {
        let view = MissionSkeletonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .whiteLarge)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        view.hidesWhenStopped = true
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.isHidden = true
        
        return view
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.backgroundColor = Constants.backroundColorDefault
//        tableView.contentInset = .init(top: 20, left: 0, bottom: safeAreaInsets.bottom + 12, right: 0)
        tableView.register(MissionTableViewCell.self, forCellReuseIdentifier: MissionTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        return tableView
    }()
    
    var isLoading: Bool = false {
        didSet {
            loadingView.isHidden = !isLoading
        }
    }
    
    override var navigationAlphaDefault: CGFloat {
        return 0
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.setRightBarButton(UIBarButtonItem(customView: rightBarButtonItemView), animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveAvatarValueChanged(_:)), name: .avatarChanged, object: nil)
        
        setupView()
        setupTableHeaderView()
        fetchData()
    }
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(loadingView)
        view.addSubview(loaderView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            loaderView.topAnchor.constraint(equalTo: view.topAnchor),
            loaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupTableHeaderView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Constants.Device.screenBounds.width, height: MissionHeaderView.height))
        headerView.frame = view.frame
        view.addSubview(headerView)
        
        tableView.tableHeaderView = view
    }
    
    // MARK: Data fetching
    private func fetchData() {
        viewModel.getTheQuestsList().subscribe(on: MainScheduler.instance).subscribe(onNext: { [weak self] quests in
            guard let this = self else { return }
            
            this.tableView.reloadData()
            this.endRefreshing()
            this.loaderView.removeFromSuperview()
        }, onError: { [weak self] error in
            guard let this = self else { return }
            
            debugPrint("Get the quests list error: \((error as? APIErrorResult)?.message ?? "ERROR")")
            this.endRefreshing()
            this.loaderView.removeFromSuperview()
        }).disposed(by: disposeBag)
    }
    
    func checkMissionCompleted(with key: QuestKey) {
        guard !isLoading else { return }
        
        isLoading = true
        viewModel.checkMissionCompleted(userID: AccountManagement.accountID, key: key).subscribe(on: MainScheduler.instance).subscribe(onNext: { [weak self] in
            guard let this = self, !$0 else { return }
            
            this.requestUserQuest(with: key)
        }, onError: { [weak self] error in
            debugPrint("Error request user quest: \((error as? APIErrorResult)?.message ?? "ERROR")")
            self?.requestUserQuest(with: key)
        }).disposed(by: disposeBag)
    }
    
    private func requestUserQuest(with key: QuestKey) {
        if key == .verifyEmail {
            let email = AccountManagement.email
            
            viewModel.verifyEmail(email).subscribe(on: MainScheduler.instance).subscribe(onNext: { [weak self] in
                guard let this = self else { return }
                
                Navigator.navigateToCheckMailVC(from: this, with: .verify, email: email)
                this.isLoading = false
            }, onError: { [weak self] error in
                AlertManagement.shared.showToast(with: "🤔 Verify email incorrect!", position: .top)
                self?.isLoading = false
            }).disposed(by: disposeBag)
        } else {
            viewModel.requestUserQuest(with: key).subscribe(on: MainScheduler.instance).subscribe(onNext: { [weak self] in
                AlertManagement.shared.showToast(with: "🎁 You have 01 free spin", position: .top)
                self?.isLoading = false
            }, onError: { [weak self] error in
                AlertManagement.shared.showToast(with: "🤔 Request incorrect!", position: .top)
                self?.isLoading = false
            }).disposed(by: disposeBag)
        }
    }
    
    // MARK: Handle actions
    @objc private func didReceiveAvatarValueChanged(_ notificaton: Notification) {
        rightBarButtonItemView.refresh()
    }
}
