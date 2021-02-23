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
        case mission
        case wallet
        case utilities
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
                navigationController.tabBarItem.title = "News"
                navigationControllers.append(navigationController)
            case .mission:
                let mission = MissionViewController()
                let navigationController = UINavigationController(rootViewController: mission)
                navigationController.tabBarItem.title = "Mission"
                navigationControllers.append(navigationController)
            case .wallet:
                let wallet = WalletViewController()
                let navigationController = UINavigationController(rootViewController: wallet)
                navigationController.tabBarItem.title = "My Wallet"
                navigationControllers.append(navigationController)
            case .utilities:
                let utilities = UtilitiesViewController()
                let navigationController = UINavigationController(rootViewController: utilities)
                navigationController.tabBarItem.title = "Utilities"
                navigationControllers.append(navigationController)
            }
        }
        
        return navigationControllers
    }
}
