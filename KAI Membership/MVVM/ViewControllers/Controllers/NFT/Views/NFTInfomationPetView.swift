//
//  NFTInfomationPetView.swift
//  KAI Membership
//
//  Created by DAKiet on 12/04/2021.
//

import UIKit

class NFTInfomationPetView: UIView {
    
    // MARK: Properties
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .init(hex: "8A94A6")
        label.font = .workSansFont(ofSize: 12, weight: .medium)
        label.text = "Name"
        
        return label
    }()
    
    private let statsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .init(hex: "8A94A6")
        label.font = .workSansFont(ofSize: 12, weight: .medium)
        label.text = "Stats"
        
        return label
    }()
    
    private lazy var editNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_edit")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentEdgeInsets = .init(top: 13, left: 13, bottom: 13, right: 13)
        button.addTarget(self, action: #selector(onPressedEditName), for: .touchUpInside)
        
        return  button
    }()
    
    private lazy var inputNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "My name pet"
        textField.tintColor = .init(hex: "ED9771")
        textField.autocorrectionType = .no
        textField.textContentType = nil
        textField.backgroundColor = nil
        textField.textColor = UIColor.black.withAlphaComponent(0.84)
        textField.font = .workSansFont(ofSize: 14, weight: .medium)
        textField.returnKeyType = .done
        textField.delegate = self
        
        return textField
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(hex: "F1F2F4")
        
        return  view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 8
        
        return stackView
    }()
    
    private let agiView: NFTParameterView = {
        let view = NFTParameterView(image: UIImage(named: "ic_agility_index"), power: "320", description: "AGI")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let strView: NFTParameterView = {
        let view = NFTParameterView(image: UIImage(named: "ic_strength_index"), power: "700", description: "STR")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let intView: NFTParameterView = {
        let view = NFTParameterView(image: UIImage(named: "ic_intelligence_quotient"), power: "128", description: "INT")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var didFinishChangePetName: ((String?) -> Void)?
    
    // MARK: Life cycle's
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func setupView() {
        addSubview(nameLabel)
        addSubview(editNameButton)
        addSubview(inputNameTextField)
        addSubview(lineView)
        addSubview(statsLabel)
        
        addSubview(stackView)
        stackView.addArrangedSubview(agiView)
        stackView.addArrangedSubview(strView)
        stackView.addArrangedSubview(intView)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            editNameButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            editNameButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            editNameButton.widthAnchor.constraint(equalToConstant: 40),
            editNameButton.heightAnchor.constraint(equalToConstant: 40),
            
            inputNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            inputNameTextField.trailingAnchor.constraint(equalTo: editNameButton.leadingAnchor),
            inputNameTextField.centerYAnchor.constraint(equalTo: editNameButton.centerYAnchor),
            inputNameTextField.heightAnchor.constraint(equalToConstant: 38),
            
            lineView.topAnchor.constraint(equalTo: editNameButton.bottomAnchor, constant: 12),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            statsLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 12),
            statsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            statsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: statsLabel.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}

// MARK: Handle actions
extension NFTInfomationPetView {
    
    @objc private func onPressedEditName() {
        
    }
}

// MARK: UITextFieldDelegate
extension NFTInfomationPetView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didFinishChangePetName?(textField.text)
        
        return textField.resignFirstResponder()
    }
}
