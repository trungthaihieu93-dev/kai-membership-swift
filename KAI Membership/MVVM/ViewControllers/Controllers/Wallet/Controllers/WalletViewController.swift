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
    
    private lazy var rightBarButtonItemView: KAIBarButtonItemView = {
        let view = KAIBarButtonItemView()
        view.delegate = self
        
        return view
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Constants.backroundColorDefault
        tableView.register(RecentTransactionsTableViewCell.self, forCellReuseIdentifier: RecentTransactionsTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        return tableView
    }()
    
    private let loaderView: WalletSkeletonView = {
        let view = WalletSkeletonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var cardView: KAICardView = {
        let view = KAICardView(with: AccountManagement.accountInfo?.kai)
        
        return view
    }()
    
    override var scroller: UIScrollView? {
        return tableView
    }
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "My Wallet"
        navigationItem.setRightBarButton(UIBarButtonItem(customView: rightBarButtonItemView), animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveAvatarValueChanged(_:)), name: .avatarChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveKaiValueChanged(_:)), name: .kaiValueChanged, object: nil)
        
        setupView()
        setupTableHeaderView()
        setupFloatyButton()
        fetchData()
    }
    
    override func refresh(_ sender: UIRefreshControl) {
        super.refresh(sender)
        fetchData()
    }
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(loaderView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            loaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupFloatyButton() {
        let floaty = Floaty()
        
        floaty.addItem("SEND", icon: UIImage(named: "ic_floaty_send")) { [weak self] (_) in
            Navigator.navigateToSendVC(from: self)
        }
        floaty.addItem("RECEIVE", icon: UIImage(named: "ic_floaty_receive")) { [weak self] (_) in
            Navigator.navigateToReceiveVC(from: self)
        }
        floaty.addItem("BUY", icon: UIImage(named : "ic_floaty_buy")) { [weak self] (_) in
            Navigator.navigateToBuyVC(from: self)
        }
        
        floaty.size = 48
        //        floaty.paddingY = tabbarHeight + 16
        
        for item in floaty.items {
            item.titleLabel.font = UIFont.workSansFont(ofSize: 10, weight: .semiBold)
            item.titleLabel.layer.cornerRadius = 8.0
            item.titleLabel.layer.masksToBounds = true
            item.titleLabel.textColor = UIColor.init(hex: "455571")
            item.titleLabel.backgroundColor = UIColor.white
            item.titleLabel.textAlignment = .center
        }
        
        self.view.addSubview(floaty)
        
        floaty.buttonColor = UIColor.Base.x500
        floaty.buttonShadowColor = .clear
        floaty.plusColor = .white
    }
    
    private func setupTableHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.Device.screenBounds.width, height: cardView.height + 24))
        cardView.frame = CGRect(x: 30, y: 12, width: headerView.frame.width - 60, height: headerView.frame.height - 24)
        headerView.addSubview(cardView)
        
        tableView.tableHeaderView = headerView
    }
    
    // MARK: Handle actions
    @objc private func didReceiveKaiValueChanged(_ notification: Notification) {
        guard let kai = notification.object as? KAIRemote else { return }
        
        cardView.configure(kai)
    }
    
    @objc private func didReceiveAvatarValueChanged(_ notificaton: Notification) {
        rightBarButtonItemView.refresh()
    }
}

// MARK: Data fetching
extension WalletViewController {
    
    private func fetchData() {
        viewModel.fetchData().subscribe(on: MainScheduler.instance).subscribe(onNext: { [weak self] transactions, user in
            guard let this = self else { return }
            
            this.cardView.configure(user.kai)
            this.tableView.reloadData()
        }, onCompleted: { [weak self] in
            guard let this = self else { return }
            
            this.endRefreshing()
            this.loaderView.removeFromSuperview()
        }).disposed(by: disposeBag)
    }
}
