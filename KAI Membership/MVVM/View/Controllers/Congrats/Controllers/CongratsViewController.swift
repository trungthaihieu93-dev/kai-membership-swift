//
//  CongratsViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 23/02/2021.
//

import UIKit

class CongratsViewController: BaseViewController {

    // MARK: Properties
    enum `Type` {
        case signUp
        case passcode
    }
    
    private let type: `Type`
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView(image: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .regular)
        label.textColor = UIColor.black.withAlphaComponent(0.87)
        label.text = "Congrats!"
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var spinLaterButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setAttributedTitle(NSAttributedString(string: "Spin Later", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.87)
        ]), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.init(hex: "C9CED6").cgColor
        button.addTarget(self, action: #selector(onPressedSpinLater), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var spinNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(onPressedSpinNow), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: Life cycle's
    init(with type: `Type`) {
        self.type = type
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(spinNowButton)
        
        containerView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: statusBarHeight).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        switch type {
        case .signUp:
            descriptionLabel.attributedText = "Welcome to Kai membership! \nYou have got 01 lucky spin".setTextWithFormat(font: .systemFont(ofSize: 14, weight: .regular), textAlignment: .center, lineHeight: 28, textColor: UIColor.black.withAlphaComponent(0.54))
            spinNowButton.setAttributedTitle(NSAttributedString(string: "Spin Now", attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]), for: .normal)
            
            containerView.addSubview(spinLaterButton)
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                
                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                
                spinLaterButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 32),
                spinLaterButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                spinLaterButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                spinLaterButton.heightAnchor.constraint(equalToConstant: 52),
                
                spinNowButton.topAnchor.constraint(equalTo: spinLaterButton.bottomAnchor, constant: 16),
                spinNowButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                spinNowButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                spinNowButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                spinNowButton.heightAnchor.constraint(equalToConstant: 52)
            ])
        case .passcode:
            descriptionLabel.attributedText = "Your new Passcode is ready.".setTextWithFormat(font: .systemFont(ofSize: 14, weight: .regular), textAlignment: .center, lineHeight: 28, textColor: UIColor.black.withAlphaComponent(0.54))
            spinNowButton.setAttributedTitle(NSAttributedString(string: "Ok, I got it", attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]), for: .normal)
            
            containerView.addSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
                imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 104),
                imageView.heightAnchor.constraint(equalToConstant: 104),
                
                titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
                titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                
                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                
                spinNowButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
                spinNowButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                spinNowButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                spinNowButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                spinNowButton.heightAnchor.constraint(equalToConstant: 52)
            ])
        }
        
        DispatchQueue.main.async {
            self.spinNowButton.gradientBackgroundColors([UIColor.init(hex: "394656").cgColor, UIColor.init(hex: "181E25").cgColor], direction: .vertical)
        }
    }
}

// MARK: Handle actions
extension CongratsViewController {
    
    @objc private func onPressedSpinLater() {
        
    }
    
    @objc private func onPressedSpinNow() {
        switch type {
        case .signUp:
            debugPrint("Spin Now")
        case .passcode:
            debugPrint("Ok, I got it")
        }
    }
}
