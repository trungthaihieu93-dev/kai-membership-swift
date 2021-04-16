//
//  NFTViewController.swift
//  KAI Membership
//
//  Created by DAKiet on 12/04/2021.
//

import UIKit
import Lottie
import SceneKit

class NFTViewController: BaseViewController, UIScrollViewDelegate {
    
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
    
    private lazy var shopButton: MaterialVerticalButton = {
        let button = MaterialVerticalButton(icon: UIImage(named: "ic_shop")!, text: "Mall", font: .workSansFont(ofSize: 10, weight: .bold), foregroundColor: .white, bgColor: .init(hex: "FF8433"), useOriginalImg: true, cornerRadius: 8)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onPressedShopButton), for: .touchUpInside)
        
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
    
    private lazy var animationView: SCNView = {
        let sceneView = SCNView()
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.contentMode = .scaleAspectFit
        sceneView.backgroundColor = .clear
        //        sceneView.loops = true
        sceneView.isPlaying = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        
        // Remote zoom camera
        sceneView.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: nil))

        // Remote move camera
        for reco in sceneView.gestureRecognizers! {
            if let panReco = reco as? UIPanGestureRecognizer {
                panReco.maximumNumberOfTouches = 1
            }
        }
        
        return sceneView
    }()
    
    private lazy var infomationPetView: NFTInfomationPetView = {
        let view = NFTInfomationPetView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.didFinishChangePetName = { [weak self] name in
            guard let this = self else { return }
            
            if let name = name, !name.isEmpty {
                // Call API change pet name
            } else {
                AlertManagement.shared.showToast(with: "🤔 Pet name not be blank!", position: .top)
            }
        }
        
        return  view
    }()
    
    private let progressView: NFTProgressView = {
        let view = NFTProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return  view
    }()
    
    private var keyboardBottomAnchor: NSLayoutConstraint?
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupView()
        setupDragon()
    }
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(backgroundAnimationView)
        view.addSubview(progressView)
        view.addSubview(animationView)
        view.addSubview(mainFuncButton)
        view.addSubview(infomationPetView)
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(feedingButton)
        stackView.addArrangedSubview(exploitButton)
        stackView.addArrangedSubview(shopButton)
        
        NSLayoutConstraint.activate([
            backgroundAnimationView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundAnimationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundAnimationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundAnimationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainFuncButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainFuncButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainFuncButton.heightAnchor.constraint(equalToConstant: 60),
            
            animationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            progressView.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 4),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            
            infomationPetView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 24),
            infomationPetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infomationPetView.bottomAnchor.constraint(equalTo: mainFuncButton.topAnchor, constant: -16),
            infomationPetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            exploitButton.heightAnchor.constraint(equalToConstant: 60),
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalToConstant: 60),
        ])
        
        keyboardBottomAnchor = mainFuncButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25)
        keyboardBottomAnchor?.isActive = true
        
        progressView.configure(level: 12, currentExp: 1275, totalExp: 2000)
    }
    
    private func setupDragon() {
        let dragonIndex: Int = 2
        
        let skinIndex: Int = 15
        let faceIndex: Int = 7
        let hornIndex: Int = 6
        let wingIndex: Int = 5
        let backIndex: Int = 23
        let teechIndex: Int = 32
        
        guard let scene = SCNScene(named: "Art.scnassets/Dragons/dragon_\(dragonIndex).scn") else { return }
        
        if let body = scene.rootNode.childNode(withName: "Body", recursively: true) {
            body.geometry?.material(named: "Body")?.diffuse.contents = "Art.scnassets/Skins/skin_\(skinIndex).png"
        }
        
        if let body = scene.rootNode.childNode(withName: "Face", recursively: true) {
            body.geometry?.material(named: "Face")?.diffuse.contents = "Art.scnassets/Eyes/face_\(faceIndex).png"
        }
        
        if let body = scene.rootNode.childNode(withName: "Horn", recursively: true) {
            body.geometry?.material(named: "Horn")?.diffuse.contents = "Art.scnassets/Skins/skin_\(hornIndex).png"
        }
        
        if let body = scene.rootNode.childNode(withName: "Wing", recursively: true) {
            body.geometry?.material(named: "Wing")?.diffuse.contents = "Art.scnassets/Skins/skin_\(wingIndex).png"
        }
        
        if let body = scene.rootNode.childNode(withName: "Back", recursively: true) {
            body.geometry?.material(named: "Back")?.diffuse.contents = "Art.scnassets/Skins/skin_\(backIndex).png"
        }
        
        if let body = scene.rootNode.childNode(withName: "Teech", recursively: true) {
            body.geometry?.material(named: "Teech")?.diffuse.contents = "Art.scnassets/Skins/skin_\(teechIndex).png"
        }
        
        animationView.scene = scene
    }
}

// MARK: Handle actions
extension NFTViewController {
    
    @objc private func handleKeyboardNotification(_ notification: NSNotification) {
        if notification.name == UIResponder.keyboardWillShowNotification {
            guard let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            keyboardBottomAnchor?.constant = -(keyboardFrame.height + 25) + tabbarHeight
        } else {
            keyboardBottomAnchor?.constant = -25
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func onPressedExploitButton() {
        
    }
    
    @objc private func onPressedFeedingButton() {
        
    }
    
    @objc private func onPressedShopButton() {
        
    }
    
    @objc private func onPressedMainFunctionButton() {
        
    }
}
