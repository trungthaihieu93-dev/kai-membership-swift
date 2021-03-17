//
//  OverviewViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 04/03/2021.
//

import UIKit
import RxSwift

class OverviewViewController: BaseViewController {
    
    // MARK: Properties
    enum `Type` {
        case topup
        case send
    }
    
    enum Section: Int, CaseIterable {
        case title
        case info
    }
    
    let viewModel: OverviewViewModel
    
    let type: `Type`
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0.01, height: 0.01))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0.01, height: 0.01))
        tableView.backgroundColor = Constants.backroundColorDefault
        tableView.contentInset = .init(top: 0, left: 0, bottom: safeAreaInsets.bottom, right: 0)
        tableView.register(CardCollapseTableViewCell.self, forCellReuseIdentifier: CardCollapseTableViewCell.identifier)
        tableView.register(OverviewTopupTableViewCell.self, forCellReuseIdentifier: OverviewTopupTableViewCell.identifier)
        tableView.register(OverviewSendTableViewCell.self, forCellReuseIdentifier: OverviewSendTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(onPressedTopup), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: Life cycle's
    init(address: String, amount: Amount) {
        self.type = .send
        self.viewModel = OverviewViewModel(address: address, amount: amount)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    init(phoneNumber: String, providerCode: String, amount: Amount) {
        self.type = .topup
        self.viewModel = OverviewViewModel(phoneNumber: phoneNumber, providerCode: providerCode, amount: amount)
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Overview"
        setupView()
    }
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            continueButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 52),
        ])
        
        switch type {
        case .topup:
            continueButton.setAttributedTitle(NSAttributedString(string: "Continue", attributes: [
                NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 16, weight: .medium),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]), for: .normal)
        case .send:
            continueButton.setAttributedTitle(NSAttributedString(string: "Send Now", attributes: [
                NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 16, weight: .medium),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]), for: .normal)
        }
        
        DispatchQueue.main.async {
            self.continueButton.gradientBackgroundColors([UIColor.init(hex: "394656").cgColor, UIColor.init(hex: "181E25").cgColor], direction: .vertical)
        }
    }
    
    // MARK: Handle actions
    @objc private func onPressedTopup() {
        switch type {
        case .topup:
            viewModel.createTopup().subscribe(on: MainScheduler.instance).subscribe(onNext: { [weak self] in
                guard let this = self else { return }
                
                debugPrint("Show Alert")
            }, onError: { error in
                debugPrint("Createt topup error: \((error as? APIErrorResult)?.message ?? "ERROR")")
            }).disposed(by: disposeBag)
        case .send:
            debugPrint("")
        }
    }
}