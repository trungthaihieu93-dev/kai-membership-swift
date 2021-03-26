//
//  EmptyTableViewCell.swift
//  KAI Membership
//
//  Created by DAKiet on 26/03/2021.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {
    
    // MARK: Properties
    private let contentImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .workSansFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor.black.withAlphaComponent(0.87)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
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
        
        contentView.addSubview(contentImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            contentImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentImageView.leadingAnchor.constraint(lessThanOrEqualTo: contentView.leadingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentImageView.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    // MARK: Configure
    func configure(image: UIImage? = nil, title: String, description: String? = nil) {
        contentImageView.image = image
        titleLabel.text = title
        descriptionLabel.attributedText = description?.setTextWithFormat(font: .workSansFont(ofSize: 14, weight: .medium), textAlignment: .center, lineHeight: 28, textColor: UIColor.black.withAlphaComponent(0.54))
    }
}
