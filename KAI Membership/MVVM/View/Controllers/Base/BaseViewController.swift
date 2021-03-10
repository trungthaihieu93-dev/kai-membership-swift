//
//  BaseViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import UIKit
import RxSwift

class BaseViewController2: UIViewController {
    
    // MARK: Properties
    let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
    
    var navigationBarHeight: CGFloat {
        return self.navigationController?.navigationBar.frame.height ?? 0
    }
    
    var tabbarHeight: CGFloat {
        return self.tabBarController?.tabBar.frame.height ?? 0
    }
    
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    var marginDefault: CGFloat {
        return 20
    }
    
//    var isHiddenNavigationBar: Bool {
//        return false
//    }
    
    var navigationAlphaDefault: CGFloat {
        return 1
    }
    
    private lazy var navigationAlpha: CGFloat = navigationAlphaDefault
    
    lazy var disposeBag = DisposeBag()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(isHiddenNavigationBar, animated: true)
        navigationBarAnimation(withAlpha: navigationAlpha)
    }
    
    // MARK: Layout
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isBeingDismissed || isMovingFromParent {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    deinit {
        debugPrint("Deinit \(identifier)")
    }
    
    func navigationBarAnimation(withAlpha alpha: CGFloat) {
        navigationAlpha = alpha
        (navigationController as? RootNavigationController)?.setBackgroundColor(UIColor.white.withAlphaComponent(alpha))
    }
}

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
    
    var bounds: CGRect {
        if !isHiddenNavigationBar && (_navigateType == .root || _navigateType == .push) {
            return CGRect(x: 0, y: navigationBarHeight, width: view.bounds.width, height: view.bounds.height - navigationBarHeight)
        } else {
            return view.bounds
        }
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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        
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
        button.layer.cornerRadius = 8
        button.createShadow(radius: 8)
        button.addTarget(self, action: #selector(_onTouchedBarBackButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var disposeBag = DisposeBag()
    
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
        
        view.addSubview(pageTitleView)
        
        pageTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pageTitleView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        if !isHiddenNavigationBar && (_navigateType == .root || _navigateType == .push) {
            view.addSubview(customNavigationBar)
            customNavigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: navigationBarHeight)
//            navigationBarAnimation(withAlpha: navigationBarAlphaDefault)
            
            if _navigateType == .push {
                customNavigationBar.addSubview(backButton)
                
                backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: statusBarHeight + 6).isActive = true
                backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
                backButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
                backButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
            }
            
            pageTitleView.topAnchor.constraint(equalTo: view.topAnchor, constant: navigationBarHeight).isActive = true
        } else {
            pageTitleView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        
        _setupTitleView()
        
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: pageTitleView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func _setupTitleView() {
        if pageTitle.isEmpty && pageDiscription.isEmpty {
            pageTitleView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        } else {
            var topAnchor: NSLayoutYAxisAnchor = pageTitleView.topAnchor
            
            if !pageTitle.isEmpty {
                _titleLabel.text = pageTitle
                _titleLabel.sizeToFit()
                pageTitleView.addSubview(_titleLabel)
                
                _titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
                _titleLabel.leadingAnchor.constraint(equalTo: pageTitleView.leadingAnchor, constant: marginDefault).isActive = true
                _titleLabel.trailingAnchor.constraint(equalTo: pageTitleView.trailingAnchor,  constant: -marginDefault).isActive = true
                topAnchor = _titleLabel.bottomAnchor
            }
            
            if pageDiscription.isEmpty {
                _titleLabel.bottomAnchor.constraint(equalTo: pageTitleView.bottomAnchor).isActive = true
            } else {
                _descriptionLabel.attributedText = pageDiscription.setTextWithFormat(font: .workSansFont(ofSize: 14, weight: .medium), lineHeight: 28, textColor: UIColor.black.withAlphaComponent(0.54))
                _descriptionLabel.sizeToFit()
                pageTitleView.addSubview(_descriptionLabel)
                
                _descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 17).isActive = true
                _descriptionLabel.leadingAnchor.constraint(equalTo: pageTitleView.leadingAnchor, constant: marginDefault).isActive = true
                _descriptionLabel.bottomAnchor.constraint(equalTo: pageTitleView.bottomAnchor, constant: -8).isActive = true
                _descriptionLabel.trailingAnchor.constraint(equalTo: pageTitleView.trailingAnchor,  constant: -marginDefault).isActive = true
            }
        }
    }
    
    // MARK: Handle actions
    @objc private func _onTouchedBarBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
