//
//  LaunchScreenViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 01/03/2021.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: Life cycle's
    override func loadView() {
        if #available(iOS 13.0, *) {
            if overrideUserInterfaceStyle == .dark {
                imageView.image = UIImage(named: "launch_screen_white")
                activityIndicatorView.color = .white
                
                return
            }
        }
        
        imageView.image = UIImage(named: "launch_screen")
        activityIndicatorView.color = .black
    }
}


