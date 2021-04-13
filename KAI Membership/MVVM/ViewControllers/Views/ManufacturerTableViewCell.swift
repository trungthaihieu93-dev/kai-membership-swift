//
//  ManufacturerTableViewCell.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 13/04/2021.
//

import UIKit

class ManufacturerTableViewCell: UITableViewCell {
    
    // MARK: Properties
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.black.withAlphaComponent(0.87)
        label.font = .workSansFont(ofSize: 14, weight: .semiBold)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        return label
    }()
    
    private let manufacturerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 8
        imageView.createShadow(radius: 8)
        
        return imageView
    }()
    
    // MARK: Life cycle's
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(manufacturerImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            manufacturerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            manufacturerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            manufacturerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            manufacturerImageView.widthAnchor.constraint(equalToConstant: 52),
            manufacturerImageView.heightAnchor.constraint(equalToConstant: 52),
            
            nameLabel.topAnchor.constraint(equalTo: manufacturerImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: manufacturerImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: manufacturerImageView.bottomAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
        ])
    }
    
    // MARK: Configure
    func configure(imageLink: String? = nil, name: String? = nil, description: String? = nil) {
        manufacturerImageView.setImage(from: imageLink, placeholder: nil)
        nameLabel.text = name
        descriptionLabel.attributedText = description?.setTextWithFormat(font: .workSansFont(ofSize: 10, weight: .medium), lineHeight: 16, textColor: UIColor.black.withAlphaComponent(0.54))
    }
}
