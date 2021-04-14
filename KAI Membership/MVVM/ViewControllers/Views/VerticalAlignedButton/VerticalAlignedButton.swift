//
//  VerticalAlignedButton.swift
//  KAI Membership
//
//  Created by DAKiet on 14/04/2021.
//

import UIKit

@IBDesignable
open class MaterialVerticalButton: UIControl {
    
    open var imageView: UIImageView!
    
    /* The icon of the button. Made exposed to storyboard. */
    @IBInspectable open var icon: UIImage = UIImage() {
        didSet {
            self.imageView.image = self.icon
        }
    }
    
    /* The boolean to set whether the segment control displays the original color of the icon. */
    @IBInspectable public var useOriginalImg: Bool = false {
        didSet {
            self.icon = useOriginalImg ? self.icon : self.icon.colored(foregroundColor)!
        }
    }
    open var label: UILabel!
    
    /* The title of the button. Made exposed to storyboard. */
    @IBInspectable open var text: String = "" {
        didSet {
            self.label.text = text
        }
    }
    
    private var imgHeightContraint: NSLayoutConstraint?
    
    /* The border color of the button. The default value is set to transparent. */
    @IBInspectable open var borderColor: UIColor = .clear {
        didSet {
            self.setCornerBorder(color: borderColor, cornerRadius: cornerRadius)
        }
    }
    
    /* The corner radius of the button. Used to round the corner. */
    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            self.setCornerBorder(color: borderColor, cornerRadius: cornerRadius)
        }
    }
    
    /* The foreground color of the button. */
    @IBInspectable open var foregroundColor: UIColor = .white {
        didSet {
            self.label.textColor = foregroundColor
            self.icon = useOriginalImg ? icon : icon.colored(foregroundColor)!
        }
    }
    
    private let coverLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.white.cgColor
        layer.opacity = 0.7
        
        return layer
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        defaultSetup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultSetup()
    }
    
    private func defaultSetup() {
        imageView = UIImageView()
        label = UILabel()
        label.textAlignment = .center
        addViews()
    }
    
    /*
     Convenience init of material design vertical aligned button with required parameters.
     
     - Parameter icon:            The icon of the button.
     - Parameter text:            The title of the button.
     - Parameter font:            The font of the button title.
     - Parameter foregroundColor: The foreground color of the button. It applies to title. It applies to icon if the useOriginalImg is false.
     - Parameter bgColor:         The background color of the button.
     - Parameter useOriginalImg:  To determine whether use the original button image or paint it with color.
     - Parameter cornerRadius:    The corner radius of the button. Used to set rounded corner.
    */
    
    public convenience init(icon: UIImage, text: String, font: UIFont? = nil,
                            foregroundColor: UIColor, bgColor: UIColor, borderColor: UIColor? = nil,
                            useOriginalImg: Bool = true, cornerRadius: CGFloat = 0.0) {
        self.init()
        
        if let font = font {
            label.font = font
        }
        
        defer {
            self.label.text = text
            self.icon = icon
            self.useOriginalImg = useOriginalImg
            self.foregroundColor = foregroundColor
            self.cornerRadius = cornerRadius
            
            if let borderColor = borderColor {
                self.borderColor = borderColor
            }
            
            self.backgroundColor = bgColor
        }
        
        addViews()
    }
    
    open func addViews() {
        [label, imageView].forEach {
            self.addSubview($0.unsafelyUnwrapped)
            $0?.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.frame.width
        let height = self.frame.height
        imageView.contentMode = .scaleAspectFit
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.03*height).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.1*width).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -0.1*width).isActive = true
        
        if imgHeightContraint != nil { imgHeightContraint.unsafelyUnwrapped.isActive = false }
        
        imgHeightContraint = imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6)
        imgHeightContraint?.isActive = true
        
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0.05*height).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.1*width).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -0.1*width).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0.03*height).isActive = true
        
        self.layoutIfNeeded()
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        coverLayer.frame = self.bounds
        coverLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
        self.layer.addSublayer(coverLayer)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        coverLayer.removeFromSuperlayer()
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        coverLayer.removeFromSuperlayer()
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
}
