//
//  RootTabbarController.swift
//  Demo KAI
//
//  Created by Anh Kiệt on 22/01/2021.
//

import UIKit

class RootTabbarController: UITabBarController {
    
    // MARK: Properties
    enum TabbarType: Int, CaseIterable {
        case news = 0
        case feeds
        case wallet
    }
    
    // MARK: Life cycle's
    override func loadView() {
        super.loadView()
        setViewControllers(viewControllers(), animated: true)
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
    }
    
    // MARK: Handle UI
    private func viewControllers() -> [UINavigationController] {
        var navigationControllers: [UINavigationController] = []
        
        TabbarType.allCases.forEach {
            switch $0 {
            case .news:
                let news = NewsViewController()
                let navigationController = UINavigationController(rootViewController: news)
                navigationController.tabBarItem.title = "Tin tức"
                navigationControllers.append(navigationController)
            case .feeds:
                let feeds = FeedsViewController()
                let navigationController = UINavigationController(rootViewController: feeds)
                navigationController.tabBarItem.title = "Feeds"
                navigationControllers.append(navigationController)
            case .wallet:
                let wallet = WalletViewController()
                let navigationController = UINavigationController(rootViewController: wallet)
                navigationController.tabBarItem.title = "Ví"
                navigationControllers.append(navigationController)
            }
        }
        
        return navigationControllers
    }
}
