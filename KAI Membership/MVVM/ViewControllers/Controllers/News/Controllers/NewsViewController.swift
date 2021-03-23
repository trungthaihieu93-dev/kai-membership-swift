//
//  NewsViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import UIKit

class NewsViewController: BaseViewController {

    // MARK: Properties
    enum Section: Int, CaseIterable {
        case suggestion
        case lastest
    }
    
    let viewModel = NewsViewModel()
    
    private lazy var rightBarButtonItemView: KAIBarButtonItemView = {
        let view = KAIBarButtonItemView()
        view.delegate = self
        
        return view
    }()
    
    private lazy var calendarPicker: KAIInputCalendarPicker = {
        let view = KAIInputCalendarPicker(baseDate: Date()) { [weak self] date in
            guard let this = self else { return }
            
            debugPrint("Selected date: \(date)")
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(NewsSuggestionTableViewCell.self, forCellReuseIdentifier: NewsSuggestionTableViewCell.identifier)
        tableView.register(NewsLastestTableViewCell.self, forCellReuseIdentifier: NewsLastestTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Today News"
        navigationItem.setRightBarButton(UIBarButtonItem(customView: rightBarButtonItemView), animated: true)
        
        setupView()
        fetchData()
        
        if AppSetting.isRequestOpenSpin {
            Navigator.openSpin(from: self)
            AppSetting.isRequestOpenSpin = false
        }
    }
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(calendarPicker)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            calendarPicker.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            calendarPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calendarPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: calendarPicker.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    // MARK: Data fetching
    func fetchData() {
        viewModel.createData()
        tableView.reloadData()
    }
}
