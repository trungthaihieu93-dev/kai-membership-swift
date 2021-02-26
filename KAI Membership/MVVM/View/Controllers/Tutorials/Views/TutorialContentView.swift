//
//  TutorialContentView.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import UIKit

class TutorialContentView: UIView {

    // MARK: Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.black.withAlphaComponent(0.87)
        label.font = UIFont.workSansFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        label.textColor = UIColor.black.withAlphaComponent(0.54)
        label.font = UIFont.workSansFont(ofSize: 14, weight: .medium)
        
        return label
    }()
    
    // MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: Layout
    func commonInit() {
        addSubview(titleLabel)
        addSubview(bodyLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            bodyLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
        ])
    }
}

// MARK: Configure
extension TutorialContentView {

    func configure(title: String? = nil, body: String? = nil) {
        titleLabel.text = title
        bodyLabel.text = body
        backgroundColor = .yellow
    }
}
