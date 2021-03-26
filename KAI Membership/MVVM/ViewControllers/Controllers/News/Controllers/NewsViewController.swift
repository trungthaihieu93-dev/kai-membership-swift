//
//  NewsViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import UIKit
import RxSwift

class NewsViewController: BaseViewController {

    // MARK: Properties
    enum Section: Int, CaseIterable {
        case suggestion
        case lastest
    }
    
    let viewModel = NewsViewModel()
    
    private let loaderView: NewsSkeletonView = {
        let view = NewsSkeletonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var rightBarButtonItemView: KAIBarButtonItemView = {
        let view = KAIBarButtonItemView()
        view.delegate = self
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Constants.backroundColorDefault
        tableView.register(NewsSuggestionTableViewCell.self, forCellReuseIdentifier: NewsSuggestionTableViewCell.identifier)
        tableView.register(NewsLastestTableViewCell.self, forCellReuseIdentifier: NewsLastestTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    override var scroller: UIScrollView? {
        return tableView
    }
    
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
    
    // MARK: Data fetching
    func fetchData() {
        viewModel.fetchNews().subscribe(on: MainScheduler.instance).subscribe(onNext: { [weak self] mediumNews, twitterNews in
            guard let this = self else { return }
            
            this.reloadData()
            this.endRefreshing()
            this.loaderView.removeFromSuperview()
        }, onError: { [weak self] error in
            guard let this = self else { return }
            
            AlertManagement.shared.showToast(with: "🤔 Get news failure!", position: .top)
            this.endRefreshing()
            this.loaderView.removeFromSuperview()
        }).disposed(by: disposeBag)
    }
    
    private func reloadData() {
        if let mediumCell = tableView.cellForRow(at: IndexPath(row: 0, section: Section.suggestion.rawValue)) as? NewsSuggestionTableViewCell, let twitterCell = tableView.cellForRow(at: IndexPath(row: 0, section: Section.lastest.rawValue)) as? NewsLastestTableViewCell {
            mediumCell.reloadWithData(viewModel.suggestions)
            twitterCell.reloadWithData(viewModel.lastests)
        } else {
            tableView.reloadData()
        }
    }
}
