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
        label.font = .systemFont(ofSize: 10, weight: .medium)
        
        return label
    }()
    
    // MARK: Life cycle
    init(title: String, placeholder: String? = nil, isSecureTextEntryEnabled: Bool = false, frame: CGRect = .zero) {
        super.init(frame: frame)
        commonInit(title: title, placeholder: placeholder, isSecureTextEntryEnabled: isSecureTextEntryEnabled)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    func commonInit(title: String, placeholder: String? = nil, isSecureTextEntryEnabled: Bool = false) {
        let textField: KAITextFieldView = KAITextFieldView(with: .normal, placeholder: placeholder, isSecureTextEntryEnabled: isSecureTextEntryEnabled)
        textField.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        
        addSubview(label)
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
