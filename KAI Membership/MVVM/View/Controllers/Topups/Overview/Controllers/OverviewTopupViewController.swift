//
//  OverviewTopupViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 04/03/2021.
//

import UIKit
import RxSwift

class OverviewTopupViewController: BaseViewController {
    
    // MARK: Properties
    let viewModel = OverviewTopupViewModel()
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Overview"
    }
}
