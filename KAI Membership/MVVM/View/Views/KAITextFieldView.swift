//
//  KAITextFieldView.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 20/02/2021.
//

import UIKit

protocol KAITextFieldViewDelegate: class {
    func kAITextFieldViewDidBeginEditing(_ textField: UITextField, for view: UIView)
    func kAITextFieldViewDidEndEditing(_ textField: UITextField, for view: UIView)
    func kAITextFieldViewDidChange(_ textField: UITextField, for view: UIView)
    func kAITextFieldViewShouldReturn(_ textField: UITextField, for view: UIView) -> Bool
    func kAITextFieldViewShouldClear(_ textField: UITextField, for view: UIView) -> Bool
}

extension KAITextFieldViewDelegate {
    func kAITextFieldViewDidBeginEditing(_ textField: UITextField, for view: UIView) {}
    func kAITextFieldViewDidEndEditing(_ textField: UITextField, for view: UIView) {}
    func kAITextFieldViewDidChange(_ textField: UITextField, for view: UIView) {}
}

class KAITextFieldView: UIView {
    
    // MARK: Properties
    enum `Type` {
        case normal
        case typing
        case disabled
        case progressing
        case success
        case error(String)
    }
    
    private let isSecureTextEntryEnabled: Bool
    
    private var type: `Type`
    
    private let validLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .workSansFont(ofSize: 11, weight: .medium)
        label.textColor = UIColor.init(hex: "ee2020")
        
        return label
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 14, weight: .medium)
        
        return label
    }()
    
    private(set) lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = nil
        textField.tintColor = .init(hex: "ED9771")
        textField.autocorrectionType = .no
//        textField.clearButtonMode = .always
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.delegate = self
        
        return textField
    }()
    
    private let activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "ic_success"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.isHidden = true
        view.backgroundColor = .green
        
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(hex: "f7f7f7")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private lazy var secureTextEntryButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(named: "ic_show_password")?.withRenderingMode(.alwaysOriginal), for: .normal)
        view.addTarget(self, action: #selector(onPressedSecureTextEntry), for: .touchUpInside)
        
        return view
    }()
    
    var isSecureTextEntry: Bool {
        didSet {
            guard isSecureTextEntryEnabled else { return }
            
            textField.isSecureTextEntry = isSecureTextEntry
            secureTextEntryButton.setImage(UIImage(named: isSecureTextEntry ? "ic_show_password" : "ic_hidden_password")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    private var inputTrailingAnchor: NSLayoutConstraint?
    private var validTopAnchor: NSLayoutConstraint?
    
    weak var delegate: KAITextFieldViewDelegate?
    
    // MARK: Life cycle's
    init(with type: `Type` = .normal, textColor: UIColor = .black, font: UIFont = .workSansFont(ofSize: 14, weight: .medium), returnKeyType: UIReturnKeyType = .default, keyboardType: UIKeyboardType = .default, placeholder: String? = nil, textAlignment: NSTextAlignment = .left, isSecureTextEntryEnabled: Bool = false, frame: CGRect = .zero) {
        self.type = type
        self.isSecureTextEntryEnabled = isSecureTextEntryEnabled
        self.isSecureTextEntry = isSecureTextEntryEnabled
        
        super.init(frame: frame)
        
        setupView()
        configure(textColor: textColor, font: font, returnKeyType: returnKeyType, keyboardType: keyboardType, placeholder: placeholder, textAlignment: textAlignment)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func setupView() {
        addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(imageView)
        imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTrailingAnchor = imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -33)
        inputTrailingAnchor?.isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 21).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        addSubview(activityView)
        activityView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        activityView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        
        addSubview(placeholderLabel)
        placeholderLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        placeholderLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        placeholderLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
        
        if isSecureTextEntryEnabled {
            addSubview(secureTextEntryButton)
            secureTextEntryButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            secureTextEntryButton.trailingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
            secureTextEntryButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
            secureTextEntryButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            placeholderLabel.trailingAnchor.constraint(equalTo: secureTextEntryButton.leadingAnchor).isActive = true
        } else {
            placeholderLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -4).isActive = true
        }
        
        addSubview(textField)
        textField.topAnchor.constraint(equalTo: placeholderLabel.topAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: placeholderLabel.leadingAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: placeholderLabel.bottomAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: placeholderLabel.trailingAnchor).isActive = true
        
        addSubview(validLabel)
        validTopAnchor = validLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0)
        validTopAnchor?.isActive = true
        validLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        validLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        validLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
    
    private func configure(textColor: UIColor, font: UIFont, returnKeyType: UIReturnKeyType = .default, keyboardType: UIKeyboardType = .default, placeholder: String? = nil, textAlignment: NSTextAlignment = .left) {
        placeholderLabel.textAlignment = textAlignment
        placeholderLabel.text = placeholder
        
        textField.textAlignment = textAlignment
        textField.textColor = textColor
        textField.font = font
        textField.returnKeyType = returnKeyType
        textField.keyboardType = keyboardType
        textField.isSecureTextEntry = isSecureTextEntryEnabled
        updateState(self.type)
    }
    
    func updateState(_ state: `Type`) {
        self.type = state
        
        switch self.type {
        case .normal:
            imageView.isHidden = true
            activityView.isHidden = true
            inputTrailingAnchor?.constant = 17
            validLabel.text = nil
            validTopAnchor?.constant = 0
            placeholderLabel.textColor = UIColor.black.withAlphaComponent(0.54)
            containerView.backgroundColor = .init(hex: "f7f7f7")
            containerView.layer.borderWidth = 0
            textField.isSelected = true
        case .disabled:
            imageView.isHidden = true
            activityView.isHidden = true
            inputTrailingAnchor?.constant = 17
            validLabel.text = nil
            validTopAnchor?.constant = 0
            placeholderLabel.textColor = .init(hex: "c1c1c1")
            containerView.backgroundColor = .init(hex: "eeeeee")
            containerView.layer.borderWidth = 0
            textField.isSelected = false
        case .typing:
            imageView.isHidden = true
            activityView.isHidden = true
            inputTrailingAnchor?.constant = 17
            validLabel.text = nil
            validTopAnchor?.constant = 0
            placeholderLabel.textColor = .init(hex: "acacac")
            containerView.backgroundColor = .white
            containerView.layer.borderColor = UIColor.init(hex: "eeeeee").cgColor
            containerView.layer.borderWidth = 1
        case .progressing:
            activityView.isHidden = false
            imageView.isHidden = true
            inputTrailingAnchor?.constant = -8
            validLabel.text = nil
            placeholderLabel.textColor = .init(hex: "acacac")
            containerView.backgroundColor = .init(hex: "f7f7f7")
            containerView.layer.borderWidth = 0
            textField.isSelected = true
        case .success:
            imageView.isHidden = false
            activityView.isHidden = true
            inputTrailingAnchor?.constant = -8
            validLabel.text = nil
            validTopAnchor?.constant = 0
            placeholderLabel.textColor = .init(hex: "acacac")
            containerView.backgroundColor = .init(hex: "f7f7f7")
            containerView.layer.borderWidth = 0
            textField.isSelected = true
        case .error(let error):
            imageView.isHidden = true
            activityView.isHidden = true
            inputTrailingAnchor?.constant = 17
            validTopAnchor?.constant = 1
            validLabel.text = error
            containerView.layer.borderColor = UIColor.init(hex: "ee2020").cgColor
            containerView.layer.borderWidth = 1
            activityView.stopAnimating()
        }
    }
    
    func setText(_ text: String? = nil) {
        isHiddenPlaceholder = !(text ?? "").isEmpty
        textField.text = text
    }
    
    func inputBecomeFirstResponder() {
        textField.becomeFirstResponder()
    }
    
    func inputResignFirstResponder() {
        textField.resignFirstResponder()
    }
    
    private var isHiddenPlaceholder: Bool = false {
        didSet {
            guard isHiddenPlaceholder != oldValue else { return }
           
            placeholderLabel.isHidden = isHiddenPlaceholder
            
            if !isHiddenPlaceholder {
                updateState(.typing)
            }
        }
    }
}

// MARK: Handle actions
extension KAITextFieldView {
    
    @objc private func onPressedSecureTextEntry(_ textField: UITextField) {
        isSecureTextEntry = !isSecureTextEntry
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        isHiddenPlaceholder = !(textField.text ?? "").isEmpty
        delegate?.kAITextFieldViewDidChange(textField, for: self)
    }
}

// MARK: UITextFieldDelegate
extension KAITextFieldView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch self.type {
        case .error(let message):
            updateState(.typing)
            updateState(.error(message))
        default:
            updateState(.typing)
        }
        
        delegate?.kAITextFieldViewDidBeginEditing(textField, for: self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch self.type {
        case .error(let message):
            updateState(.normal)
            updateState(.error(message))
        default:
            updateState(.normal)
        }
        
        delegate?.kAITextFieldViewDidEndEditing(textField, for: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch self.type {
        case .error(let message):
            updateState(.normal)
            updateState(.error(message))
        default:
            updateState(.normal)
        }
        
        return delegate?.kAITextFieldViewShouldReturn(textField, for: self) ?? false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return delegate?.kAITextFieldViewShouldClear(textField, for: self) ?? true
    }
}
