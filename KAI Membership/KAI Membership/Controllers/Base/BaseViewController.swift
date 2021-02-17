//
//  BaseViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: Life cycle's
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
