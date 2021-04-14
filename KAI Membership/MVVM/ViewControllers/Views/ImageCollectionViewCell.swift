//
//  ImageCollectionViewCell.swift
//  KAI Membership
//
//  Created by DAKiet on 14/04/2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: Life cycle's
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func setupView() {
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    // MARK: Methods
    func configure(imageLink: String? = nil) {
        imageView.setImage(from: imageLink, placeholder: nil)
    }
}
