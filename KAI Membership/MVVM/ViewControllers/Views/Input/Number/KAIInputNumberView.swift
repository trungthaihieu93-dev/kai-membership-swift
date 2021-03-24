//
//  KAIInputNumberView.swift
//  KAI Membership
//
//  Created by DAKiet on 24/03/2021.
//

import UIKit

class KAIInputNumberView: UIView {

    // MARK: Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 10, weight: .medium)
        label.textColor = .init(hex: "364766")
        
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        return label
    }()
    
    private let inputNumber: KAIInputNumber
    
    var contentInput: String = ""
    
    weak var delegate: KAITextFieldDelegate?
    
    // MARK: Life cycle's
    init(withTitle title: String, text: String? = nil, isEnabled: Bool = true, isSelected: Bool = true, returnKeyType: UIReturnKeyType = .default, placeholder: String? = nil, textAlignment: NSTextAlignment = .left, frame: CGRect = .zero) {
        self.inputNumber = KAIInputNumber(withText: text, isEnabled: isEnabled, isSelected: isSelected, returnKeyType: returnKeyType, placeholder: placeholder, textAlignment: textAlignment, frame: frame)
        
        super.init(frame: frame)
        
        setupView(with: title)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func setupView(with title: String) {
        inputNumber.translatesAutoresizingMaskIntoConstraints = false
        inputNumber.delegate = self
        titleLabel.text = title
        
        addSubview(titleLabel)
        addSubview(inputNumber)
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            
            inputNumber.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            inputNumber.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputNumber.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: inputNumber.bottomAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setMessage(_ message: String? = nil) {
        guard let message = message, !message.isEmpty else {
            messageLabel.attributedText = nil
            return
        }
        
        messageLabel.attributedText = message.setTextWithFormat(font: .workSansFont(ofSize: 12, weight: .medium), lineHeight: 16, textColor: UIColor.init(hex: "C42C15"))
    }
    
    func reset() {
        inputNumber.reset()
    }
    
    func inputBecomeFirstResponder() {
        inputNumber.inputBecomeFirstResponder()
    }
    
    func setText(_ text: String) {
        contentInput = text
        inputNumber.setText(text)
    }
    
    func setAttributedText(_ attributedText: NSAttributedString) {
        contentInput = attributedText.string
        inputNumber.setAttributedText(attributedText)
    }
}

// MARK: KAITextFieldDelegate
extension KAIInputNumberView: KAIInputNumberDelegate {
    
    func kAIInputNumberDidBeginEditing(_ textField: UITextField, for view: UIView) {
        delegate?.kAITextFieldDidBeginEditing(textField, for: self)
    }
    
    func kAIInputNumberDidEndEditing(_ textField: UITextField, for view: UIView) {
        delegate?.kAITextFieldDidEndEditing(textField, for: self)
    }
    
    func kAIInputNumberDidChange(_ textField: UITextField, for view: UIView) {
        contentInput = textField.text ?? ""
        messageLabel.attributedText = nil
        delegate?.kAITextFieldDidChange(textField, for: self)
    }
    
    func kAIInputNumberShouldReturn(_ textField: UITextField, for view: UIView) -> Bool {
        return delegate?.kAITextFieldShouldReturn(textField, for: self) ?? false
    }
    
    func kAIInputNumberShouldClear(_ textField: UITextField, for view: UIView) -> Bool {
        return delegate?.kAITextFieldShouldClear(textField, for: self) ?? true
    }
}
