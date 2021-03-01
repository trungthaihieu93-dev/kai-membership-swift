//
//  UIView+Extensions.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import UIKit

extension UIView {
    
    enum GradientDirection {
        case horizontal
        case vertical
        case adjust(CGPoint, CGPoint)
        
        var points: (start: CGPoint, end: CGPoint) {
            switch self {
            case .horizontal:
                return (start: .init(x: 0.0, y: 0.5), end: .init(x: 1.0, y: 0.5))
            case .vertical:
                return (start: .init(x: 0.5, y: 0.0), end: .init(x: 0.5, y: 1.0))
            case .adjust(let start, let end):
                return (start: start, end: end)
            }
        }
    }
    
    enum ShadowDirection {
        case `default`
        case top
        case left
        case bottom
        case right
        case adjust(CGSize)
        
        var offset: CGSize {
            switch self {
            case .default:
                return .zero
            case .top:
                return CGSize(width: 0, height: -10)
            case .left:
                return CGSize(width: -10, height: 0)
            case .bottom:
                return CGSize(width: 0, height: 10)
            case .right:
                return CGSize(width: 10, height: 0)
            case .adjust(let size):
                return size
            }
        }
    }
    
    func removeAllSublayers(withName name: String) {
        layer.sublayers?.forEach {
            if $0.name == name {
                $0.removeFromSuperlayer()
            }
        }
    }
    
    func createShadow(radius: CGFloat, color: UIColor = .black, direction: ShadowDirection = .default) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = direction.offset
        layer.shadowRadius = radius
        layer.shouldRasterize = true // Lưu vào bộ nhớ cache của bóng được hiển thị để nó không cần phải được vẽ lại
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func gradientBackgroundColors(_ colors: [CGColor], direction: GradientDirection) {
        removeAllSublayers(withName: "GradientLayerKey")
        backgroundColor = .clear
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.startPoint = direction.points.start
        gradientLayer.endPoint = direction.points.end
        gradientLayer.colors = colors
        gradientLayer.name = "GradientLayerKey"
        gradientLayer.cornerRadius = layer.cornerRadius
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func removeAllSubviews() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}
