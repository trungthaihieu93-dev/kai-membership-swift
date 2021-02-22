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
        return UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets(top: 44, left: 0, bottom: 34, right: 0)
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
    
    let pageTitleView: UIView = {
        let view = UIView()
        view.backgroundColor = nil
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightText
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
        label.numberOfLines = 2
        
        return label
    }()
    
    private(set) lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_back"), for: .normal)
        button.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 8
        button.layer.shouldRasterize = true // Lưu vào bộ nhớ cache của bóng được hiển thị để nó không cần phải được vẽ lại
        button.layer.rasterizationScale = UIScreen.main.scale
        button.addTarget(self, action: #selector(_onTouchecBarBackButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if !pageTitle.isEmpty || !pageDiscription.isEmpty {
            _titleLabel.text = pageTitle
            _titleLabel.sizeToFit()
            _descriptionLabel.attributedText = pageDiscription.setTextWithFormat(font: .systemFont(ofSize: 14, weight: .medium), lineHeight: 28, textColor: UIColor.black.withAlphaComponent(0.54))
            _descriptionLabel.sizeToFit()
            
            view.addSubview(pageTitleView)
            
            pageTitleView.addSubview(backButton)
            pageTitleView.addSubview(_titleLabel)
            pageTitleView.addSubview(_descriptionLabel)
            
            NSLayoutConstraint.activate([
                pageTitleView.topAnchor.constraint(equalTo: view.topAnchor),
                pageTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                pageTitleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                backButton.topAnchor.constraint(equalTo: pageTitleView.topAnchor, constant: statusBarHeight + 6),
                backButton.leadingAnchor.constraint(equalTo: pageTitleView.leadingAnchor, constant: 20),
                backButton.widthAnchor.constraint(equalToConstant: 32),
                backButton.heightAnchor.constraint(equalToConstant: 32),
                
                _titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 6),
                _titleLabel.leadingAnchor.constraint(equalTo: pageTitleView.leadingAnchor, constant: marginDefault),
                _titleLabel.trailingAnchor.constraint(equalTo: pageTitleView.trailingAnchor,  constant: -marginDefault),
                
                _descriptionLabel.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 17),
                _descriptionLabel.leadingAnchor.constraint(equalTo: pageTitleView.leadingAnchor, constant: marginDefault),
                _descriptionLabel.bottomAnchor.constraint(equalTo: pageTitleView.bottomAnchor, constant: -8),
                _descriptionLabel.trailingAnchor.constraint(equalTo: pageTitleView.trailingAnchor,  constant: -marginDefault),
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
        view.bringSubviewToFront(pageTitleView)
    }
    
    // MARK: Handle actions
    @objc private func _onTouchecBarBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
