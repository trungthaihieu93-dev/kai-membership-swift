//
//  UIStackView+Extensions.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 09/04/2021.
//

import UIKit

extension UIStackView {
    
    func removeFully(_ view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            removeFully($0)
        }
    }
}
