//
//  PasscodeView.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 27/02/2021.
//

import UIKit

protocol PasscodeViewDelegate: class {
    func passcodeViewDelegateStatusEntered(with status: PasscodeView.CodeStatus, _ passcodeView: PasscodeView)
}

class PasscodeView: UIView {
    
    // MARK: Properties
    enum `Type`: Int {
        case four = 4
        case six = 6
    }
    
    enum CodeStatus {
        case enoughCode
        case haveNotEnoughCode
    }
    
    private let type: PasscodeView.`Type`
    
    private let codeOneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.backgroundColor = .init(hex: "f7f7f7")
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        
        return label
    }()
    
    private let codeTwoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.backgroundColor = .init(hex: "f7f7f7")
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        
        return label
    }()
    
    private let codeThreeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.backgroundColor = .init(hex: "f7f7f7")
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        
        return label
    }()
    
    private let codeFourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.backgroundColor = .init(hex: "f7f7f7")
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        
        return label
    }()
    
    private let codeFiveLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.backgroundColor = .init(hex: "f7f7f7")
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        
        return label
    }()
    
    private let codeSixLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 15)
        label.backgroundColor = .init(hex: "f7f7f7")
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8
        
        return label
    }()
    
    private let containerStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 4
        
        return view
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.keyboardType = .numberPad
        textField.inputAccessoryView = UIView(frame: .zero)
        textField.isHidden = true
        textField.delegate = self
        
        if #available(iOS 12.0, *) {
            textField.textContentType = .oneTimeCode
        } else {
            // Fallback on earlier versions
        }
        
        return textField
    }()
    
    private lazy var codeLables: [UILabel] = [
        codeOneLabel,
        codeTwoLabel,
        codeThreeLabel,
        codeFourLabel,
        codeFiveLabel,
        codeSixLabel
    ]
    
    var code: String = ""
    
    weak var delegate: PasscodeViewDelegate?
    
    // MARK: Life cycle's
    init(with type: PasscodeView.`Type`, frame: CGRect = .zero) {
        self.type = type
        
        super.init(frame: frame)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    func setupView() {
        backgroundColor = .white
        
        addSubview(textField)
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(codeOneLabel)
        containerStackView.addArrangedSubview(codeTwoLabel)
        containerStackView.addArrangedSubview(codeThreeLabel)
        containerStackView.addArrangedSubview(codeFourLabel)
        
        if type == .six {
            containerStackView.addArrangedSubview(codeFiveLabel)
            containerStackView.addArrangedSubview(codeSixLabel)
        }
        
        containerStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        containerStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        codeOneLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func inputBecomeFirstResponder() {
        textField.becomeFirstResponder()
    }
    
    private func insertCode(_ number: String) {
        code.append(number)
        
        let count = code.count
        
        guard count > 0 else { return }
        
        let index = code.index(before: code.endIndex)
        codeLables[count - 1].text = String(code[index])
    }
    
    private func deleteCode() {
        let count = code.count
        
        guard count > 0 else { return }
        
        code.removeLast()
        codeLables[count - 1].text = nil
    }
    
    func reset() {
        textField.text = nil
        code.removeAll()
        
        for codeLable in codeLables {
            codeLable.text = nil
        }
    }
}

// MARK: UITextFieldDelegate
extension PasscodeView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString = NSString(string: textField.text ?? "")
        let newString = currentString.replacingCharacters(in: range, with: string)
        
        if newString.count == type.rawValue {
            insertCode(string)
            delegate?.passcodeViewDelegateStatusEntered(with: .enoughCode, self)
            
            return true
        } else if newString.count <= type.rawValue {
            if string.isEmpty {
                deleteCode()
            } else {
                insertCode(string)
            }
            
            delegate?.passcodeViewDelegateStatusEntered(with: .haveNotEnoughCode, self)
            
            return true
        }
        
        return false
    }
}
