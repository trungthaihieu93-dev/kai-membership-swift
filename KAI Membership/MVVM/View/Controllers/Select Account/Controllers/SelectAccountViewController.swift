//
//  SelectAccountViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import UIKit

class SelectAccountViewController: BaseViewController {

    // MARK: Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
//        tableView.estimatedRowHeight = 44
//        tableView.rowHeight = 100//UITableView.automaticDimension
        tableView.contentInset = .init(top: 20, left: 0, bottom: 34, right: 0)
        tableView.register(SelectAccountTableViewCell.self, forCellReuseIdentifier: SelectAccountTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    override var pageTitle: String {
        return "Select Account"
    }
    
    override var pageDiscription: String {
        return "Choose the account you want."
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
            tableView.topAnchor.constraint(equalTo: pageTitleView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    // MARK: Handle actions
    @objc private func onPressedSignInAnotherAccount() {
        Navigator.navigateToSignInVC(from:  self)
    }
}

// MARK: UITableViewDataSource
extension SelectAccountViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(NSAttributedString(string: "Sign in to another account", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.init(hex: "017CAD")
        ]), for: .normal)
        button.addTarget(self, action: #selector(onPressedSignInAnotherAccount), for: .touchUpInside)
        footerView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: footerView.topAnchor),
            button.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
            button.bottomAnchor.constraint(equalTo: footerView.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: footerView.trailingAnchor)
        ])
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectAccountTableViewCell.identifier, for: indexPath) as! SelectAccountTableViewCell
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension SelectAccountViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Navigator.navigateToPasscodeVC(from: self, with: .signIn)
    }
}

