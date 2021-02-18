//
//  BaseViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: Properties
    let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
    
    var marginDefault: CGFloat {
        return 20
    }
    
    var safeAreaInsets: UIEdgeInsets {
        return UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
    }
    
    var tabbarHeight: CGFloat {
        return self.tabBarController?.tabBar.frame.size.height ?? 0
    }
    
    var pageTitle: String {
        return ""
    }
    
    var pageDiscription: String {
        return ""
    }
    
    private let _pageTitleView: UIView = {
        let view = UIView()
        view.backgroundColor = nil
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let _titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.black.withAlphaComponent(0.87)
        label.font = .systemFont(ofSize: 36, weight: .regular)
        
        return label
    }()
    
    private let _descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.black.withAlphaComponent(0.54)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        return label
    }()
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if !pageTitle.isEmpty || !pageDiscription.isEmpty {
            _titleLabel.text = pageTitle
            _titleLabel.sizeToFit()
            _descriptionLabel.text = pageDiscription
            _descriptionLabel.sizeToFit()
            
            view.addSubview(_pageTitleView)
            
            _pageTitleView.addSubview(_titleLabel)
            _pageTitleView.addSubview(_descriptionLabel)
            
            NSLayoutConstraint.activate([
                _pageTitleView.topAnchor.constraint(equalTo: view.topAnchor),
                _pageTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                _pageTitleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                _titleLabel.topAnchor.constraint(equalTo: _pageTitleView.topAnchor, constant: statusBarHeight),
                _titleLabel.leadingAnchor.constraint(equalTo: _pageTitleView.leadingAnchor, constant: marginDefault),
                _titleLabel.trailingAnchor.constraint(equalTo: _pageTitleView.trailingAnchor,  constant: -marginDefault),
                
                _descriptionLabel.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 17),
                _descriptionLabel.leadingAnchor.constraint(equalTo: _pageTitleView.leadingAnchor, constant: marginDefault),
                _descriptionLabel.bottomAnchor.constraint(equalTo: _pageTitleView.bottomAnchor),
                _descriptionLabel.trailingAnchor.constraint(equalTo: _pageTitleView.trailingAnchor,  constant: -marginDefault),
            ])
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.bringSubviewToFront(_pageTitleView)
    }
}
