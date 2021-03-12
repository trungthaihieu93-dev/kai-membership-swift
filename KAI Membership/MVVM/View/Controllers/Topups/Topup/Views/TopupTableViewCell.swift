//
//  TopupTableViewCell.swift
//  KAI Membership
//
//  Created by DAKiet on 11/03/2021.
//

import UIKit

class TopupTableViewCell: UITableViewCell {
    
    // MARK: Properties
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.init(hex: "F1F2F4").cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    private let contactLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 10, weight: .medium)
        label.textColor = .init(hex: "364766")
        label.text = "PHONE NO."
        
        return label
    }()
    
    private lazy var contactTextField: KAITextField = {
        let view = KAITextField(with: .default, keyboardType: .phonePad, placeholder: "e.g 01669919308")
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.delegate = self
        
        return view
    }()
    
    private let comboboxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 10, weight: .medium)
        label.textColor = .init(hex: "364766")
        label.text = "TOP UP AMOUNT"
        
        return label
    }()
    
    private let combobox: KAICombobox = {
        let view = KAICombobox(with: ["10.000 VND", "20.000 VND", "50.000 VND", "100.000 VND", "200.000 VND", "500.000 VND"])
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
        
        contentView.addSubview(containerView)
            
        containerView.addSubview(contactLabel)
        containerView.addSubview(contactTextField)
        containerView.addSubview(comboboxLabel)
        containerView.addSubview(combobox)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            contactLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            contactLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            contactLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            contactTextField.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 4),
            contactTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            contactTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            comboboxLabel.topAnchor.constraint(equalTo: contactTextField.bottomAnchor, constant: 100),
            comboboxLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            comboboxLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            combobox.topAnchor.constraint(equalTo: comboboxLabel.bottomAnchor, constant: 4),
            combobox.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            combobox.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            combobox.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
        ])
    }
    
    // MARK: Layout
    func configure() {
        
    }
}
