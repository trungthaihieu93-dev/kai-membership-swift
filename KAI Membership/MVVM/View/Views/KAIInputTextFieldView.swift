//
//  KAIInputTextFieldView.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 20/02/2021.
//

import UIKit

class KAIInputTextFieldView: UIView {

    // MARK: Properties
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 10, weight: .medium)
        
        return label
    }()
    
    private var kaiTextFieldView: KAITextFieldView!
    
    var contentInput: String = ""
    
    weak var delegate: KAITextFieldViewDelegate?
    
    // MARK: Life cycle's
    init(title: String, placeholder: String? = nil, isSecureTextEntryEnabled: Bool = false, frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView(title: title, placeholder: placeholder, isSecureTextEntryEnabled: isSecureTextEntryEnabled)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func setupView(title: String, placeholder: String? = nil, isSecureTextEntryEnabled: Bool = false) {
        kaiTextFieldView = KAITextFieldView(with: .normal, placeholder: placeholder, isSecureTextEntryEnabled: isSecureTextEntryEnabled)
        kaiTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        kaiTextFieldView.delegate = self
        label.text = title
        
        addSubview(label)
        addSubview(kaiTextFieldView)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            
            kaiTextFieldView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4),
            kaiTextFieldView.leadingAnchor.constraint(equalTo: leadingAnchor),
            kaiTextFieldView.bottomAnchor.constraint(equalTo: bottomAnchor),
            kaiTextFieldView.trailingAnchor.constraint(equalTo: trailingAnchor),
            kaiTextFieldView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func reset() {
        kaiTextFieldView.reset()
    }
    
    func inputBecomeFirstResponder() {
        kaiTextFieldView.inputBecomeFirstResponder()
    }
}

// MARK: KAITextFieldViewDelegate
extension KAIInputTextFieldView: KAITextFieldViewDelegate {
    
    func kAITextFieldViewDidBeginEditing(_ textField: UITextField, for view: UIView) {
        delegate?.kAITextFieldViewDidBeginEditing(textField, for: self)
    }
    
    func kAITextFieldViewDidEndEditing(_ textField: UITextField, for view: UIView) {
        delegate?.kAITextFieldViewDidEndEditing(textField, for: self)
    }
    
    func kAITextFieldViewDidChange(_ textField: UITextField, for view: UIView) {
        contentInput = textField.text ?? ""
        delegate?.kAITextFieldViewDidChange(textField, for: self)
    }
    
    func kAITextFieldViewShouldReturn(_ textField: UITextField, for view: UIView) -> Bool {
        return delegate?.kAITextFieldViewShouldReturn(textField, for: self) ?? false
    }
    
    func kAITextFieldViewShouldClear(_ textField: UITextField, for view: UIView) -> Bool {
        return delegate?.kAITextFieldViewShouldClear(textField, for: self) ?? true
    }
}
