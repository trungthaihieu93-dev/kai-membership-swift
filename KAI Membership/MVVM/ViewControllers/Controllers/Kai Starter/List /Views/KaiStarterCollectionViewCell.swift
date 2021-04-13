//
//  KaiStarterCollectionViewCell.swift
//  KAI Membership
//
//  Created by DAKiet on 31/03/2021.
//

import UIKit

class KaiStarterCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    static let height: CGFloat = 418
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
//        view.createShadow(radius: 12, direction: .bottom)
        
        return view
    }()
    
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.black.withAlphaComponent(0.87)
        label.font = .workSansFont(ofSize: 20, weight: .semiBold)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private let currnetKaiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.black.withAlphaComponent(0.87)
        
        return label
    }()
    
    private let backersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.black.withAlphaComponent(0.87)
        
        return label
    }()
    
    private let progressBar: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.progressTintColor = .init(hex: "394656")
        view.trackTintColor = .init(hex: "E6EAEF")
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private let totalKaiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.black.withAlphaComponent(0.54)
        
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
        contentView.addSubview(containerView)
        
        containerView.addSubview(contentImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(currnetKaiLabel)
        containerView.addSubview(backersLabel)
        containerView.addSubview(progressBar)
        containerView.addSubview(totalKaiLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            contentImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            contentImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            contentImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            contentImageView.heightAnchor.constraint(equalTo: contentImageView.widthAnchor, multiplier: 213 / 342),
            
            titleLabel.topAnchor.constraint(equalTo: contentImageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            currnetKaiLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            currnetKaiLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            backersLabel.centerYAnchor.constraint(equalTo: currnetKaiLabel.centerYAnchor),
            backersLabel.leadingAnchor.constraint(lessThanOrEqualTo: currnetKaiLabel.trailingAnchor, constant: 8),
            backersLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            progressBar.topAnchor.constraint(equalTo: currnetKaiLabel.bottomAnchor, constant: 4),
            progressBar.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            progressBar.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            progressBar.heightAnchor.constraint(equalToConstant: 8),
            
            totalKaiLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 4),
            totalKaiLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            totalKaiLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            totalKaiLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
        ])
    }
    
    // MARK: Methods
    func configure(with project: KaiProjectRemote) {
        contentImageView.setImage(from: project.imageLink, placeholder: nil)
        titleLabel.text = project.name
        descriptionLabel.attributedText = project.description?.setTextWithFormat(font: .workSansFont(ofSize: 14, weight: .medium), textColor: UIColor.black.withAlphaComponent(0.54), lineHeightMultiple: 1.22)
        currnetKaiLabel.text = project.current.formatCurrencyToString(unit: .kai)
        backersLabel.text = "\(project.backers ?? 0) backers"
        let totalKai = project.target ?? 0
        let progress = totalKai > 0 ? project.current / totalKai : 1
        progressBar.progress = Float(progress)
        totalKaiLabel.text = "\(progress * 100)% of \(totalKai.formatCurrencyToString(unit: .kai))"
    }
}
