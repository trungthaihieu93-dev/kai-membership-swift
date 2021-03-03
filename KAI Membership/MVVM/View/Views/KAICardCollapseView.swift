//
//  KAICardCollapseView.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 04/03/2021.
//

import UIKit

class KAICardCollapseView: UIView {
    
    // MARK: Properties
    
    // MARK: Life cycle's
    init(kai: Double, frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func setupView() {
        backgroundColor = .red
    }
}
