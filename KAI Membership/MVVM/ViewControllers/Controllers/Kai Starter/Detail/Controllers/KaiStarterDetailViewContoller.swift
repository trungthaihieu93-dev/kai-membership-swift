//
//  KaiStarterDetailViewContoller.swift
//  KAI Membership
//
//  Created by DAKiet on 31/03/2021.
//

import UIKit

class KaiStarterDetailViewContoller: BaseViewController {

    // MARK: Properties
    enum SectionType: Int, CaseIterable {
        case title
        case description
    }
    
    enum TitleItemType: Int, CaseIterable {
        case media
        case manufacturer
    }
    
    let viewModel: KaiStarterDetailViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Constants.backroundColorDefault
        tableView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(KaiStarterDetailMediaTableViewCell.self, forCellReuseIdentifier: KaiStarterDetailMediaTableViewCell.identifier)
        tableView.register(ManufacturerTableViewCell.self, forCellReuseIdentifier: ManufacturerTableViewCell.identifier)
        tableView.register(KaiStarterDetailDescriptionTableViewCell.self, forCellReuseIdentifier: KaiStarterDetailDescriptionTableViewCell.identifier)
        tableView.dataSource = self
//        tableView.delegate = self
        
        return tableView
    }()
    
    private lazy var investButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .init(hex: "67798E")
        button.setImage(UIImage(named: "ic_money_buy"), for: .normal)
        button.tintColor = .white
        button.titleEdgeInsets.left = 4
        button.titleEdgeInsets.right = -4
        button.imageEdgeInsets.left = -4
        button.imageEdgeInsets.right = 4
        button.contentEdgeInsets = .init(top: 2, left: 16, bottom: 2, right: 16)
        button.setAttributedTitle(NSAttributedString(string: "Invest", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 14, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]), for: .normal)
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(onPressedInvestButton), for: .touchUpInside)
        
        return button
    }()
    
    var isSuccess: Bool = false {
        didSet {
            let indexPath: IndexPath = IndexPath(row: 0, section: SectionType.description.rawValue)
            
            investButton.isHidden = isSuccess
            
            if let cell = tableView.cellForRow(at: indexPath) as? KaiStarterDetailDescriptionTableViewCell {
                cell.isSuccess = isSuccess
            } else {
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
    
    // MARK: Life cycle's
    init(with id: String, and title: String) {
        self.viewModel = KaiStarterDetailViewModel(with: id)
        
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(investButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            investButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            investButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            investButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    // MARK: Handle actions
    @objc private func onPressedInvestButton() {
        
    }
}
