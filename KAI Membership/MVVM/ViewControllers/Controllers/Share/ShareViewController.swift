//
//  ShareViewController.swift
//  KAI Membership
//
//  Created by DAKiet on 22/03/2021.
//

import UIKit

class ShareViewController: BaseViewController {
    
    // MARK: Properties
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.createShadow(radius: 24)
        
        return view
    }()
    
    override var backroundColorDefault: UIColor {
        return UIColor.black.withAlphaComponent(0.1)
    }
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: Layout
    private func setupView() {
        
    }
}
