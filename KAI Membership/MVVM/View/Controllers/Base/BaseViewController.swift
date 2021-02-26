//
//  BaseViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: Properties
    private enum NavigateType {
        case root
        case child
        case present
        case push
    }
    
    private var _navigateType: NavigateType = .child
    
    let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
    let navigationBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height + 52
    
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
    
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    var navigationBarAlphaDefault: CGFloat {
        return 1
    }
    
    var isHiddenNavigationBar: Bool {
        return false
    }
    
    let customNavigationBar: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        
        return view
    }()
    
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
        label.font = .workSansFont(ofSize: 36, weight: .regular)
        
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
        button.layer.createShadow(radius: 8, color: .black)
        button.addTarget(self, action: #selector(_onTouchedBarBackButton), for: .touchUpInside)
        
        return button
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if isBeingPresented {
            _navigateType = .present
        } else {
            if let navigationController = self.navigationController {
                if navigationController.viewControllers.last === self {
                    if navigationController.viewControllers.count < 2 {
                        _navigateType = .root
                    } else {
                        _navigateType = .push
                    }
                } else {
                    _navigateType = .child
                }
            } else {
                _navigateType = .child
            }
        }
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard _navigateType == .root || _navigateType == .push else { return }
        
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
        view.bringSubviewToFront(customNavigationBar)
    }
    
    deinit {
        debugPrint("Deinit \(identifier)")
    }
    
    // MARK: Layouts
    private func setupView() {
        view.backgroundColor = .white
        
        if !isHiddenNavigationBar && (_navigateType == .root || _navigateType == .push) {
            view.addSubview(customNavigationBar)
            customNavigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: navigationBarHeight)
            navigationBarAnimation(withAlpha: navigationBarAlphaDefault)
            
            if _navigateType == .push {
                customNavigationBar.addSubview(backButton)
                
                backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: statusBarHeight + 6).isActive = true
                backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
                backButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
                backButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
            }
        }
        
        if !pageTitle.isEmpty || !pageDiscription.isEmpty {
            _titleLabel.text = pageTitle
            _titleLabel.sizeToFit()
            _descriptionLabel.attributedText = pageDiscription.setTextWithFormat(font: .workSansFont(ofSize: 14, weight: .medium), lineHeight: 28, textColor: UIColor.black.withAlphaComponent(0.54))
            _descriptionLabel.sizeToFit()
            
            view.addSubview(pageTitleView)
            pageTitleView.addSubview(_titleLabel)
            pageTitleView.addSubview(_descriptionLabel)
            
            if !isHiddenNavigationBar && (_navigateType == .root || _navigateType == .push) {
                pageTitleView.topAnchor.constraint(equalTo: view.topAnchor, constant: navigationBarHeight).isActive = true
            } else {
                pageTitleView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            }
            
            NSLayoutConstraint.activate([
                pageTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                pageTitleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                _titleLabel.topAnchor.constraint(equalTo: pageTitleView.topAnchor),
                _titleLabel.leadingAnchor.constraint(equalTo: pageTitleView.leadingAnchor, constant: marginDefault),
                _titleLabel.trailingAnchor.constraint(equalTo: pageTitleView.trailingAnchor,  constant: -marginDefault),
                
                _descriptionLabel.topAnchor.constraint(equalTo: _titleLabel.bottomAnchor, constant: 17),
                _descriptionLabel.leadingAnchor.constraint(equalTo: pageTitleView.leadingAnchor, constant: marginDefault),
                _descriptionLabel.bottomAnchor.constraint(equalTo: pageTitleView.bottomAnchor, constant: -8),
                _descriptionLabel.trailingAnchor.constraint(equalTo: pageTitleView.trailingAnchor,  constant: -marginDefault),
            ])
        }
        
    }
    
    func navigationBarAnimation(withAlpha alpha: CGFloat) {
        guard !isHiddenNavigationBar else { return }

    }
    
    // MARK: Handle actions
    @objc private func _onTouchedBarBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
