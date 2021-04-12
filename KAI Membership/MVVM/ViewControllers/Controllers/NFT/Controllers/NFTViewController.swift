//
//  NFTViewController.swift
//  KAI Membership
//
//  Created by DAKiet on 12/04/2021.
//

import UIKit
import Lottie

class NFTViewController: BaseViewController {
    
    // MARK: Properties
    private lazy var exploitButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.contentEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        button.setImage(UIImage(named: "ic_exploit")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 8
        button.createShadow(radius: 8)
        button.addTarget(self, action: #selector(onPressedExploitButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var feedingButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.contentEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        button.setImage(UIImage(named: "ic_feeding")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 8
        button.createShadow(radius: 8)
        button.addTarget(self, action: #selector(onPressedFeedingButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var mainFuncButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .init(hex: "C42C15")
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.init(hex: "A8170F").cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(onPressedMainFunctionButton), for: .touchUpInside)
        
        return button
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 16
        view.distribution = .fillEqually
        
        return view
    }()
    
    private let backgroundAnimationView: AnimationView = {
        let animationView = AnimationView(name: "")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
//          animationView.animationSpeed = 0.5
        animationView.play()
        
        return animationView
    }()
    
    private let animationView: AnimationView = {
        let animationView = AnimationView(name: "")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundColor = .yellow
        
        return animationView
    }()
    
    private let infomationPetView: NFTInfomationPetView = {
        let view = NFTInfomationPetView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        
        return  view
    }()
    
    private let progressView: NFTProgressView = {
        let view = NFTProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return  view
    }()
    
    override var navigationAlphaDefault: CGFloat {
        return 0
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        setupView()
    }
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(backgroundAnimationView)
        view.addSubview(mainFuncButton)
        view.addSubview(infomationPetView)
        view.addSubview(progressView)
        view.addSubview(animationView)
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(feedingButton)
        stackView.addArrangedSubview(exploitButton)
        
        NSLayoutConstraint.activate([
            backgroundAnimationView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundAnimationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundAnimationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundAnimationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainFuncButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainFuncButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            mainFuncButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainFuncButton.heightAnchor.constraint(equalToConstant: 60),
            
            infomationPetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infomationPetView.bottomAnchor.constraint(equalTo: mainFuncButton.topAnchor, constant: -16),
            infomationPetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            progressView.bottomAnchor.constraint(equalTo: infomationPetView.topAnchor, constant: -40),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
//            progressView.heightAnchor.constraint(equalToConstant: 46),
            
            animationView.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -24),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 240),
            
            exploitButton.heightAnchor.constraint(equalToConstant: 60),
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalToConstant: 60),
        ])
        
        progressView.configure(level: 12, currentExp: 1275, totalExp: 2000)
    }
}

// MARK: Handle actions
extension NFTViewController {
    
    @objc private func onPressedExploitButton() {
        
    }
    
    @objc private func onPressedFeedingButton() {
        
    }
    
    @objc private func onPressedMainFunctionButton() {
        
    }
}
