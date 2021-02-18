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
    
    func removeAllSublayers(withName name: String) {
        layer.sublayers?.forEach {
            if $0.name == name {
                $0.removeFromSuperlayer()
            }
        }
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
