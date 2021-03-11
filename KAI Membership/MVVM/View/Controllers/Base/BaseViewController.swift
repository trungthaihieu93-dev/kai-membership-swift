//
//  BaseViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
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
    
    var navigationColorDefault: UIColor {
        return .white
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
        navigationBarAnimation(withAlpha: navigationAlpha, backgroundColor: navigationColorDefault)
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
    
    func navigationBarAnimation(withAlpha alpha: CGFloat, backgroundColor: UIColor = .white) {
        navigationAlpha = alpha
        (navigationController as? RootNavigationController)?.setBackgroundColor(backgroundColor.withAlphaComponent(alpha))
    }
}
