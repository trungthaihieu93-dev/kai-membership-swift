//
//  BaseViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: Properties
    let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
    let pageTitleHeight: CGFloat = UIApplication.shared.statusBarFrame.height + 52
    
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
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if !pageTitle.isEmpty {
            _titleLabel.text = pageTitle
            _titleLabel.sizeToFit()
            
            view.addSubview(_pageTitleView)
            _pageTitleView.addSubview(_titleLabel)
            
            NSLayoutConstraint.activate([
                _pageTitleView.topAnchor.constraint(equalTo: view.topAnchor),
                _pageTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                _pageTitleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                _titleLabel.topAnchor.constraint(equalTo: _pageTitleView.topAnchor, constant: statusBarHeight),
                _titleLabel.leadingAnchor.constraint(equalTo: _pageTitleView.leadingAnchor, constant: 20),
                _titleLabel.bottomAnchor.constraint(equalTo: _pageTitleView.bottomAnchor),
                _titleLabel.trailingAnchor.constraint(equalTo: _pageTitleView.trailingAnchor,  constant: -20),
            ])
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        if isBeingDismissed || isMovingFromParent {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.bringSubviewToFront(_pageTitleView)
    }
}
