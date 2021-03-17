//
//  KAIBarButtonItemView.swift
//  KAI Membership
//
//  Created by DAKiet on 08/03/2021.
//

import UIKit

protocol KAIBarButtonItemViewDelegate: class {
    func kAIBarButtonItemViewDidSelecteSpin(_ kAIBarButtonItemView: KAIBarButtonItemView)
    func kAIBarButtonItemViewDidSelecteProfile(_ kAIBarButtonItemView: KAIBarButtonItemView)
}

class KAIBarButtonItemView: UIView {
    
    // MARK: Properties
    private lazy var spinButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_spin")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.createShadow(radius: 8)
        button.addTarget(self, action: #selector(onPressedSpin), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_profile")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .white
        button.contentEdgeInsets = .init(top: 2, left: 2, bottom: 2, right: 2)
        button.imageView?.layer.cornerRadius = 8
        button.layer.cornerRadius = 8
        button.createShadow(radius: 8)
        button.addTarget(self, action: #selector(onPressedProfile), for: .touchUpInside)
        
        return button
    }()
    
    weak var delegate: KAIBarButtonItemViewDelegate?
    
    // MARK: Life cycle's
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func setupView() {
        addSubview(spinButton)
        addSubview(profileButton)
        
        NSLayoutConstraint.activate([
            profileButton.topAnchor.constraint(equalTo: topAnchor),
            profileButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            profileButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileButton.widthAnchor.constraint(equalToConstant: 36),
            profileButton.heightAnchor.constraint(equalToConstant: 36),
            
            spinButton.topAnchor.constraint(equalTo: profileButton.topAnchor),
            spinButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            spinButton.bottomAnchor.constraint(equalTo: profileButton.bottomAnchor),
            spinButton.trailingAnchor.constraint(equalTo: profileButton.leadingAnchor, constant: -4),
            spinButton.widthAnchor.constraint(equalTo: profileButton.widthAnchor),
            spinButton.heightAnchor.constraint(equalTo: profileButton.heightAnchor),
        ])
        
        refresh()
    }
    
    // MARK: Methods
    func refresh() {
        profileButton.setImage(from: AccountManagement.user.avatarLink, placeholder: UIImage(named: "ic_profile")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    // MARK: Handle actions
    @objc private func onPressedSpin() {
        delegate?.kAIBarButtonItemViewDidSelecteSpin(self)
    }
    
    @objc private func onPressedProfile() {
        delegate?.kAIBarButtonItemViewDidSelecteProfile(self)
    }
}
