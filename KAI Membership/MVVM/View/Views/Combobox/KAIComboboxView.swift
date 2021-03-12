//
//  KAIComboboxView.swift
//  KAI Membership
//
//  Created by DAKiet on 12/03/2021.
//

import UIKit

class KAIComboboxView: UIView {

    // MARK: Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 10, weight: .medium)
        label.textColor = .init(hex: "364766")
        
        return label
    }()
    
    private let combobox: KAICombobox
    
    // MARK: Life cycle's
    init(with title: String, dataSources: [String], frame: CGRect = .zero) {
        self.combobox = KAICombobox(with: dataSources)
        
        super.init(frame: frame)
        
        setupView(with: title)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func setupView(with title: String) {
        combobox.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        
        addSubview(titleLabel)
        addSubview(combobox)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            
            combobox.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            combobox.leadingAnchor.constraint(equalTo: leadingAnchor),
            combobox.bottomAnchor.constraint(equalTo: bottomAnchor),
            combobox.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
