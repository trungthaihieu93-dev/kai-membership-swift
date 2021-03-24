//
//  KAIInputNumber.swift
//  KAI Membership
//
//  Created by DAKiet on 24/03/2021.
//

import UIKit

protocol KAIInputNumberDelegate: class {
    func kAIInputNumberDidBeginEditing(_ textField: UITextField, for view: UIView)
    func kAIInputNumberDidEndEditing(_ textField: UITextField, for view: UIView)
    func kAIInputNumberDidChange(_ textField: UITextField, for view: UIView)
    func kAIInputNumberShouldReturn(_ textField: UITextField, for view: UIView) -> Bool
    func kAIInputNumberShouldClear(_ textField: UITextField, for view: UIView) -> Bool
}

extension KAIInputNumberDelegate {
    func kAIInputNumberDidBeginEditing(_ textField: UITextField, for view: UIView) {}
    func kAIInputNumberDidEndEditing(_ textField: UITextField, for view: UIView) {}
    func kAIInputNumberDidChange(_ textField: UITextField, for view: UIView) {}
}

class KAIInputNumber: UIView {
    
    // MARK: Properties
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
        label.isUserInteractionEnabled = false
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
        textField.textContentType = nil
        textField.isSecureTextEntry = false
        textField.keyboardType = .decimalPad
        textField.textColor = UIColor.black.withAlphaComponent(0.84)
        textField.font = .workSansFont(ofSize: 14, weight: .medium)
//        textField.clearButtonMode = .always
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.delegate = self
        
        return textField
    }()
    
    private let placeholder: String?
    
    var contentInput: String = ""
    
    weak var delegate: KAIInputNumberDelegate?
    
    // MARK: Life cycle's
    init(withText text: String? = nil, isEnabled: Bool = true, isSelected: Bool = true, returnKeyType: UIReturnKeyType = .default, placeholder: String? = nil, textAlignment: NSTextAlignment = .left, frame: CGRect = .zero) {
        self.placeholder = placeholder
        
        super.init(frame: frame)
        
        placeholderLabel.text = placeholder
        placeholderLabel.textAlignment = textAlignment
        textField.textAlignment = textAlignment
        textField.returnKeyType = returnKeyType
        textField.isUserInteractionEnabled = isSelected
        setupView(isEnabled)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    func setupView(_ isEnabled: Bool) {
        addSubview(containerView)
        
        containerView.addSubview(textField)
        containerView.addSubview(placeholderLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 44),
            
            textField.topAnchor.constraint(equalTo: containerView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            placeholderLabel.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor),
            placeholderLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            placeholderLabel.widthAnchor.constraint(equalTo: textField.widthAnchor),
        ])
        
        textField.isEnabled = isEnabled
        containerView.backgroundColor = isEnabled ? .init(hex: "FAFBFB") : .init(hex: "F1F2F4")
    }
    
    // MARK: Methods
    func inputBecomeFirstResponder() {
        textField.becomeFirstResponder()
    }
    
    func inputResignFirstResponder() {
        textField.resignFirstResponder()
    }
    
    func reset() {
        textField.text = nil
        textField.becomeFirstResponder()
    }
    
    func setText(_ text: String) {
        contentInput = text
        textField.text = text
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    func setAttributedText(_ attributedText: NSAttributedString) {
        contentInput = attributedText.string
        textField.attributedText = attributedText
        placeholderLabel.isHidden = !contentInput.isEmpty
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        contentInput = textField.text ?? ""
        placeholderLabel.isHidden = !contentInput.isEmpty
        delegate?.kAIInputNumberDidChange(textField, for: self)
    }
}

// MARK: UITextFieldDelegate
extension KAIInputNumber: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.kAIInputNumberDidBeginEditing(textField, for: self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.kAIInputNumberDidEndEditing(textField, for: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.kAIInputNumberShouldReturn(textField, for: self) ?? false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return delegate?.kAIInputNumberShouldClear(textField, for: self) ?? true
    }
}
