//
//  Navigator.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 19/02/2021.
//

import UIKit

final class Navigator {
    
    static weak var window: UIWindow? {
        if #available(iOS 13, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }

            return window
        }
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate, let window = delegate.window else { return nil }
        
        return window
    }
    
    /* Hiện màn hình giới thiệu */
    class func showTutorialVC() {
        let vc = TutorialViewController()
        window?.rootViewController = UINavigationController(rootViewController: vc)
    }
    
    /* Điều hướng sang màn hình đăng nhập */
    class func navigateToSignInVC(from viewController: UIViewController? = nil) {
        let vc = SignInViewController()
        vc.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
