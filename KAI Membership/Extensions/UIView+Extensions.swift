//
//  UIView+Extensions.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import UIKit
import SkeletonView

extension UIView {
    
    static let gradientLayerKey: String = "GradientLayerKey"
    
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
        removeAllSublayers(withName: UIView.gradientLayerKey)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.startPoint = direction.points.start
        gradientLayer.endPoint = direction.points.end
        gradientLayer.colors = colors
        gradientLayer.name = UIView.gradientLayerKey
        gradientLayer.cornerRadius = layer.cornerRadius
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func removeAllSubviews() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}

extension UIView {
    /*
     Set the corner radius of the view.
     
     - Parameter color:        The color of the border.
     - Parameter cornerRadius: The radius of the rounded corner.
     - Parameter borderWidth:  The width of the border.
     */
    open func setCornerBorder(color: UIColor? = nil, cornerRadius: CGFloat = 15.0, borderWidth: CGFloat = 1) {
        self.layer.borderColor = color != nil ? color!.cgColor : UIColor.clear.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
    }
    
    /*
     Set the shadow layer of the view.
     
     - Parameter bounds:       The bounds in CGRect of the shadow.
     - Parameter cornerRadius: The radius of the shadow path.
     - Parameter shadowRadius: The radius of the shadow.
     */
    func setAsShadow(bounds: CGRect, cornerRadius: CGFloat = 0.0, shadowRadius: CGFloat = 1, color: UIColor) {
        self.backgroundColor = UIColor.clear
        self.layer.shadowColor = color.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = true
        self.clipsToBounds = false
    }
}
