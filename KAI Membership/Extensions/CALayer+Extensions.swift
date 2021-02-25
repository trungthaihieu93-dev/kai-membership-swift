//
//  CALayer+Extensions.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 25/02/2021.
//

import UIKit

extension CALayer {
    
    func createShadow(radius: CGFloat, color: UIColor) {
        cornerRadius = radius
        shadowColor = color.cgColor
        shadowOpacity = 0.1
        shadowOffset = .zero
        shadowRadius = radius
        shouldRasterize = true // Lưu vào bộ nhớ cache của bóng được hiển thị để nó không cần phải được vẽ lại
        rasterizationScale = UIScreen.main.scale
    }
}
