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
        imageView.contentMode = .scaleAspectFill
        
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
        label.lineBreakMode = .byTruncatingMiddle
        label.font = .workSansFont(ofSize: 10, weight: .medium)
        label.textColor = UIColor.init(hex: "0A1F44")
        
        return label
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Constants.backroundColorDefault
//        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        button.setImage(UIImage(named: "ic_share_arrow")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.titleEdgeInsets.left = 8
        button.imageEdgeInsets.right = 8
        button.setAttributedTitle(NSAttributedString(string: "Share", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 12, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.init(hex: "364766")
        ]), for: .normal)
        button.sizeToFit()
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
            walletContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            walletContainerView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            shareButton.topAnchor.constraint(equalTo: walletContainerView.topAnchor, constant: 8),
            shareButton.bottomAnchor.constraint(equalTo: walletContainerView.bottomAnchor, constant: -8),
            shareButton.trailingAnchor.constraint(equalTo: walletContainerView.trailingAnchor, constant: -12),
            shareButton.heightAnchor.constraint(equalToConstant: 32),
            shareButton.widthAnchor.constraint(equalToConstant: 70),
            
            addressWalletLabel.centerYAnchor.constraint(equalTo: walletContainerView.centerYAnchor),
            addressWalletLabel.leadingAnchor.constraint(equalTo: walletContainerView.leadingAnchor, constant: 12),
            addressWalletLabel.trailingAnchor.constraint(lessThanOrEqualTo: shareButton.leadingAnchor, constant: -8),
        ])
        
        configure()
    }
    
    // MARK: Configure
    func configure() {
        nameLabel.text = "Bảo Ngọc"
        emailLabel.text = "ngoc.bao@gmail.com"
        addressWalletLabel.text = "Q24-EUZP-IUGY-935R-P8GH-U7RASH5PP6NSH5PP6NGSH5PP6NGSH5PP6NGSH5PP6NGSH5PP6NGSH5PP6NGSH5PP6NGSH5PP6NGSH5PP6NGSH5PP6NG-N4W"
    }
    
    func zoomImage(with value: CGFloat) {
        coverImageTopAnchor?.constant = value
    }
}
