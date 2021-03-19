//
//  HistoryTableViewCell.swift
//  KAI Membership
//
//  Created by DAKiet on 17/03/2021.
//

import UIKit
import RNLoadingButton_Swift

class HistoryTableViewCell: UITableViewCell {
    
    // MARK: Properties
    private let contentImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "ic_money_bag"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.black.withAlphaComponent(0.87)
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 10, weight: .medium)
        label.textColor = UIColor.init(hex: "0E8C31")
        
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private lazy var actionButton: RNLoadingButton = {
        let button = RNLoadingButton()
        button.backgroundColor = .init(hex: "E6EAEF")
        button.setAttributedTitle(NSAttributedString(string: "Redeem", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 12, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.init(hex: "29323D")
        ]), for: .normal)
        button.layer.cornerRadius = 8
        button.activityIndicatorAlignment = RNActivityIndicatorAlignment.left
        button.activityIndicatorEdgeInsets.left = 16
        button.hideTextWhenLoading = false
        button.isLoading = false
        button.activityIndicatorColor = .white
        button.addTarget(self, action: #selector(onPressedAction), for: .touchUpInside)
        
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.createShadow(radius: 8)
        
        return view
    }()
    
    var isActionEnabled: Bool = true {
        didSet {
            actionButton.isEnabled = isActionEnabled
            actionButton.isLoading = !isActionEnabled
        }
    }
    
    var didFinishTouchedAction: (() -> Void)?
    
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
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(contentImageView)
        containerView.addSubview(stackView)
        
        stackView.addArrangedSubview(infoStackView)
        
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            contentImageView.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: 12),
            contentImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            contentImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            contentImageView.widthAnchor.constraint(equalToConstant: 45),
            contentImageView.heightAnchor.constraint(equalToConstant: 45),
            
            stackView.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: 12),
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentImageView.trailingAnchor, constant: 8),
        ])
    }
    
    // MARK: Methods
    func configure(_ history: HistoryRemote) {
        stackView.removeArrangedSubview(actionButton)
        stackView.addArrangedSubview(actionButton)
        
//        if history.status == .inProgress {
//            stackView.addArrangedSubview(actionButton)
//        }
        
        titleLabel.text = history.rewardName
    }
    
    // MARK: Handle actions
    @objc private func onPressedAction() {
        isActionEnabled = false
        didFinishTouchedAction?()
    }
}
