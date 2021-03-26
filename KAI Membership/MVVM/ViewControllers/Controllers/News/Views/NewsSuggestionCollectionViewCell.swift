//
//  NewsSuggestionCollectionViewCell.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 05/03/2021.
//

import UIKit

class NewsSuggestionCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    private let coverImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    private let coverBackgroundTitleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private let publicDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.white.withAlphaComponent(0.7)
        
        return label
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
        contentView.addSubview(coverImageView)
        contentView.addSubview(coverBackgroundTitleView)
        contentView.addSubview(publicDateLabel)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            coverBackgroundTitleView.topAnchor.constraint(equalTo: topAnchor),
            coverBackgroundTitleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverBackgroundTitleView.bottomAnchor.constraint(equalTo: bottomAnchor),
            coverBackgroundTitleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            publicDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            publicDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            publicDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            titleLabel.leadingAnchor.constraint(equalTo: publicDateLabel.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: publicDateLabel.topAnchor, constant: -12),
            titleLabel.trailingAnchor.constraint(equalTo: publicDateLabel.trailingAnchor),
        ])
    }
    
    // MARK: Configure
    func configure(_ new: MediumNews) {
        coverImageView.setImage(from: new.thumbnail)
        publicDateLabel.text = new.publicDate
        titleLabel.attributedText = new.title?.setTextWithFormat(font: .workSansFont(ofSize: 16, weight: .semiBold), lineHeight: 26, textColor: .white, lineHeightMultiple: 1.39)
    }
}
