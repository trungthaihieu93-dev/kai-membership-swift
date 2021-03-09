//
//  ProfileHeaderView.swift
//  KAI Membership
//
//  Created by DAKiet on 09/03/2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
    // MARK: Properties
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bg_profile"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.createShadow(radius: 12)
        
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 28, weight: .semiBold)
        label.textColor = UIColor.black.withAlphaComponent(0.87)
        
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.black.withAlphaComponent(0.26)
        
        return label
    }()
    
    private let walletContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(hex: "FAFBFB")
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.init(hex: "E1E4E8").cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    private let addressWalletLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 10, weight: .medium)
        label.textColor = UIColor.init(hex: "0A1F44")
        
        return label
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .init(hex: "F7F8F9")
        button.setImage(UIImage(named: "ic_share_arrow"), for: .normal)
        button.setTitle("Share", for: .normal)
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 8)
        button.titleEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 8)
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    private var coverImageTopAnchor: NSLayoutConstraint?
    
    // MARK: Life cycle's
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    func setupView() {
        addSubview(backgroundImageView)
        addSubview(containerView)
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(emailLabel)
        containerView.addSubview(walletContainerView)
        
        walletContainerView.addSubview(addressWalletLabel)
        walletContainerView.addSubview(shareButton)
        
        coverImageTopAnchor = backgroundImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        coverImageTopAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -68),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            walletContainerView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 12),
            walletContainerView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            walletContainerView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            addressWalletLabel.centerXAnchor.constraint(equalTo: walletContainerView.centerXAnchor),
            addressWalletLabel.leadingAnchor.constraint(equalTo: walletContainerView.leadingAnchor, constant: 12),
            
            shareButton.topAnchor.constraint(equalTo: walletContainerView.topAnchor, constant: 8),
            shareButton.leadingAnchor.constraint(greaterThanOrEqualTo: addressWalletLabel.trailingAnchor, constant: 10),
            shareButton.bottomAnchor.constraint(equalTo: walletContainerView.bottomAnchor, constant: -8),
            shareButton.trailingAnchor.constraint(equalTo: walletContainerView.trailingAnchor, constant: -12),
            shareButton.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        configure()
    }
    
    // MARK: Configure
    func configure() {
        nameLabel.text = "Bảo Ngọc"
        emailLabel.text = "ngoc.bao@gmail.com"
        addressWalletLabel.text = "Q24-EUZP-IUGY-935R-P8GH-U7RA...SH5PP6NG-N4W"
    }
    
    func zoomImage(with value: CGFloat) {
        coverImageTopAnchor?.constant = value
    }
}
