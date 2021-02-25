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
    
    /* Hiện màn hình lựa chọn tài khoản sử dụng */
    class func showSelectAccountVC() {
        let vc = SelectAccountViewController()
        window?.rootViewController = UINavigationController(rootViewController: vc)
    }
    
    /* Điều hướng sang màn hình đăng nhập */
    class func navigateToSignInVC(from viewController: UIViewController? = nil) {
        let vc = SignInViewController()
        vc.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    /* Điều hướng sang màn hình đăng ký */
    class func navigateToSignUpVC(from viewController: UIViewController? = nil) {
        let vc = SignUpViewController()
        vc.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    /* Điều hướng sang màn hình làm mới mật khẩu */
    class func navigateToResetPasswordVC(from viewController: UIViewController? = nil) {
        let vc = ResetPasswordViewController()
        vc.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    /* Điều hướng sang màn hình quên mật khẩu */
    class func navigateToForgotPasswordVC(from viewController: UIViewController? = nil) {
        let vc = ForgotPasswordViewController()
        vc.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    /* Điều hướng sang màn hình kiểm tra email */
    class func navigateToCheckMailVC(from viewController: UIViewController? = nil) {
        let vc = CheckMailViewController()
        vc.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
     Điều hướng sang màn hình mật mã
     - parameter type: Loại hiển thị
     */
    class func navigateToPasscodeVC(from viewController: UIViewController? = nil, with type: PasscodeViewController.`Type`) {
        let vc = PasscodeViewController(with: type)
        vc.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
     Điều hướng sang màn hình chúc mừng (đã đăng ký tài khoản hoăc đã cập nhật mật khẩu) thành công
     - parameter type: Loại hiển thị
     */
    class func navigateToCongratsVC(from viewController: UIViewController? = nil, with type: CongratsViewController.`Type`) {
        let vc = CongratsViewController(with: type)
        vc.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
