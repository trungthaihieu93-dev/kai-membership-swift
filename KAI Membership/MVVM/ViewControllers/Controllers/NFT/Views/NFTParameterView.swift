//
//  NFTParameterView.swift
//  KAI Membership
//
//  Created by DAKiet on 12/04/2021.
//

import UIKit

class NFTParameterView: UIView {
    
    // MARK: Properties
    private let powerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .init(hex: "364766")
        label.font = .workSansFont(ofSize: 18, weight: .semiBold)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.black.withAlphaComponent(0.54)
        label.font = .workSansFont(ofSize: 12, weight: .medium)
        
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: Life cycle's
    init(image: UIImage? = nil, power: String? = nil, description: String? = nil, frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupView()
        configure(image: image, power: power, description: description)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func setupView() {
        addSubview(imageView)
        addSubview(powerLabel)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 32),
            imageView.heightAnchor.constraint(equalToConstant: 32),
            
            powerLabel.topAnchor.constraint(equalTo: topAnchor),
            powerLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            powerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: powerLabel.bottomAnchor, constant: 2),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    // MARK: Configure
    func configure(image: UIImage?, power: String? = nil, description: String? = nil) {
        imageView.image = image
        powerLabel.text = power
        descriptionLabel.text = description
    }
}
