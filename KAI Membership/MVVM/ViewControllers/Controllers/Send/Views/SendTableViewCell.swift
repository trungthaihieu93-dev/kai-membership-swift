//
//  SendTableViewCell.swift
//  KAI Membership
//
//  Created by DAKiet on 17/03/2021.
//

import UIKit

protocol SendTableViewCellDelegate: class {
    func sendTableViewCellTextFieldDidValueChanged(_ sendTableViewCell: SendTableViewCell, textField: UITextField, inputType: SendTableViewCell.InputType)
}

class SendTableViewCell: UITableViewCell {
    
    // MARK: Properties
    enum InputType {
        case walletAddress
        case amount
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.init(hex: "F1F2F4").cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    private let walletAddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 10, weight: .medium)
        label.textColor = .init(hex: "364766")
        label.text = "ADDRESS"
        
        return label
    }()
    
    private lazy var walletAddressTextField: KAITextField = {
        let view = KAITextField(with: .default, placeholder: "Recipient Address")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 10, weight: .medium)
        label.textColor = .init(hex: "364766")
        label.text = "SEND AMOUNT"
        
        return label
    }()
    
    private lazy var amountTextField: KAITextField = {
        let view = KAITextField(with: .default, keyboardType: .phonePad, placeholder: "KAI Amount")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    weak var delegate: SendTableViewCellDelegate?
    
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
            
        containerView.addSubview(walletAddressLabel)
        containerView.addSubview(walletAddressTextField)
        containerView.addSubview(amountLabel)
        containerView.addSubview(amountTextField)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            walletAddressLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            walletAddressLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            walletAddressLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            walletAddressTextField.topAnchor.constraint(equalTo: walletAddressLabel.bottomAnchor, constant: 4),
            walletAddressTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            walletAddressTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            amountLabel.topAnchor.constraint(equalTo: walletAddressTextField.bottomAnchor, constant: 12),
            amountLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            amountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            amountTextField.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 4),
            amountTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            amountTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            amountTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
        ])
    }
}

// MARK: KAITextFieldDelegate
extension SendTableViewCell: KAITextFieldDelegate {

    func kAITextFieldDidChange(_ textField: UITextField, for view: UIView) {
        if view == walletAddressTextField {
            delegate?.sendTableViewCellTextFieldDidValueChanged(self, textField: textField, inputType: .walletAddress)
        } else if view == amountTextField {
            delegate?.sendTableViewCellTextFieldDidValueChanged(self, textField: textField, inputType: .amount)
        }
    }
    
    func kAITextFieldShouldReturn(_ textField: UITextField, for view: UIView) -> Bool {
        return false
    }
    
    func kAITextFieldShouldClear(_ textField: UITextField, for view: UIView) -> Bool {
        return true
    }
}
