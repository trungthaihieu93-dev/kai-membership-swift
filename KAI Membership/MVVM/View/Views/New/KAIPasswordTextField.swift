//
//  KAIPasswordTextField.swift
//  KAI Membership
//
//  Created by DAKiet on 10/03/2021.
//

import UIKit

class KAIPasswordTextField: UIView {
    
    // MARK: Properties
    enum State {
        case normal
        case disabled
        case failed
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(hex: "FAFBFB")
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(hex: "E1E4E8").cgColor
        
        return view
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.black.withAlphaComponent(0.54)
        
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = nil
        textField.tintColor = .init(hex: "ED9771")
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.textColor = UIColor.black.withAlphaComponent(0.84)
        textField.font = .workSansFont(ofSize: 14, weight: .medium)
        //        textField.clearButtonMode = .always
        //        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        //        textField.delegate = self
        
        return textField
    }()
    
    private lazy var secureTextEntryButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(named: "ic_show_password")?.withRenderingMode(.alwaysOriginal), for: .normal)
        view.addTarget(self, action: #selector(onPressedSecureTextEntry), for: .touchUpInside)
        
        return view
    }()
    
    private let placeholder: String?
    
    var isSecureTextEntry: Bool = true {
        didSet {
            textField.isSecureTextEntry = isSecureTextEntry
            secureTextEntryButton.setImage(UIImage(named: isSecureTextEntry ? "ic_show_password" : "ic_hide_password")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    var state: State = .normal {
        didSet {
            switch state {
            case .normal:
                textField.isSecureTextEntry = isSecureTextEntry
                secureTextEntryButton.setImage(UIImage(named: isSecureTextEntry ? "ic_show_password" : "ic_hide_password")?.withRenderingMode(.alwaysOriginal), for: .normal)
                textField.isEnabled = true
                secureTextEntryButton.isEnabled = true
                containerView.layer.borderColor = UIColor.init(hex: "E1E4E8").cgColor
                containerView.backgroundColor = .init(hex: "FAFBFB")
            case .disabled:
                textField.isSecureTextEntry = true
                secureTextEntryButton.setImage(UIImage(named: "ic_show_password")?.withRenderingMode(.alwaysOriginal), for: .normal)
                textField.isEnabled = false
                secureTextEntryButton.isEnabled = false
                containerView.layer.borderColor = UIColor.init(hex: "E1E4E8").cgColor
                containerView.backgroundColor = .init(hex: "F1F2F4")
            case .failed:
                textField.isSecureTextEntry = true
                secureTextEntryButton.setImage(UIImage(named: "ic_failed")?.withRenderingMode(.alwaysOriginal), for: .normal)
                textField.isEnabled = true
                secureTextEntryButton.isEnabled = false
                containerView.layer.borderColor = UIColor.init(hex: "C42C15").cgColor
                containerView.backgroundColor = .init(hex: "FAFBFB")
            }
        }
    }
    
    // MARK: Life cycle's
    init(with state: State = .normal, returnKeyType: UIReturnKeyType = .default, keyboardType: UIKeyboardType = .default, placeholder: String? = nil, textAlignment: NSTextAlignment = .left, frame: CGRect = .zero) {
        self.placeholder = placeholder
        
        super.init(frame: frame)
        
        self.state = state
        placeholderLabel.text = placeholder
        placeholderLabel.textAlignment = textAlignment
        textField.textAlignment = textAlignment
        textField.returnKeyType = returnKeyType
        textField.keyboardType = keyboardType
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func setupView() {
        addSubview(containerView)
        
        containerView.addSubview(textField)
        containerView.addSubview(placeholderLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 44),
            
            textField.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            textField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            placeholderLabel.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor),
            placeholderLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            placeholderLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            placeholderLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: Handle actions
    @objc private func onPressedSecureTextEntry() {
        isSecureTextEntry = !isSecureTextEntry
    }
}
