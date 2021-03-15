//
//  OverviewViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 04/03/2021.
//

import UIKit
import RxSwift

class OverviewViewController: BaseViewController {
    
    // MARK: Properties
    enum `Type` {
        case topup
        case send
    }
    
    let viewModel: OverviewViewModel
    
    private let type: `Type`
    
    // MARK: Life cycle's
    init(address: String, amount: Double) {
        self.type = .send
        self.viewModel = OverviewViewModel(address: address, amount: amount)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    init(phoneNumber: String, serviceProvider: String, amount: Double) {
        self.type = .topup
        self.viewModel = OverviewViewModel(phoneNumber: phoneNumber, serviceProvider: serviceProvider, amount: amount)
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Overview"
        setupView()
    }
    
    // MARK: Layout
    private func setupView() {
        
    }
}
