//
//  KaiStarterDetailDescriptionTableViewCell.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 13/04/2021.
//

import UIKit

class KaiStarterDetailDescriptionTableViewCell: UITableViewCell {
    
    // MARK: Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.black.withAlphaComponent(0.87)
        label.font = .workSansFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    private let successfulStickerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ic_successful_sticker"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    var isSuccess: Bool = false {
        didSet {
            successfulStickerImageView.removeFromSuperview()
            
            if isSuccess {
                contentView.addSubview(successfulStickerImageView)
                
                NSLayoutConstraint.activate([
                    successfulStickerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                    successfulStickerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                    successfulStickerImageView.widthAnchor.constraint(equalToConstant: 120),
                    successfulStickerImageView.heightAnchor.constraint(equalToConstant: 50)
                ])
            }
        }
    }
    
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
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerView.topAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    // MARK: Configure
    func configure(title: String) {
        titleLabel.text = title
    }
}
