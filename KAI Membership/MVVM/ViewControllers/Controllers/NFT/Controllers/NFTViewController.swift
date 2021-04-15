//
//  NFTViewController.swift
//  KAI Membership
//
//  Created by DAKiet on 12/04/2021.
//

import UIKit
import Lottie
import SceneKit

enum RotationMode: Int{
    case quaternion, inertialHomegrown, inertialApplePhysics
}

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
    
    var touchedObject: VirtualObject?
    let sphere = VirtualObject()
    let sphereAnchor = SCNNode()
    var previousScale = simd_float3()
    let updateQueue = DispatchQueue(label: "update queue")
    var mode: RotationMode = .quaternion
    
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
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer(_:)))
        panGesture.minimumNumberOfTouches = 2
        panGesture.maximumNumberOfTouches = 2
        animationView.addGestureRecognizer(panGesture)
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
    
    @objc private func handlePanGestureRecognizer(_ recognizer: UIPanGestureRecognizer) {
        let scnView = recognizer.view as! SCNView
                
                // check what we tapped
                let p = recognizer.location(in: scnView)
                let hitResults = scnView.hitTest(p, options: [:])
                // check that we clicked on at least one object
                if let hit = hitResults.first, hit.node == sphere {
                    // retrieved the first clicked object
                    touchedObject = sphere
                    let worldTouch = simd_float3(hit.worldCoordinates)
                    let localTouch = simd_float3(hit.localCoordinates)
                
                    switch recognizer.state{
                    case .began:
                        updateQueue.async {
                            switch self.mode{
                            case .inertialApplePhysics:
                                self.touchedObject?.previousTouch = localTouch
                            default:
                                self.touchedObject?.previousTouch = worldTouch
                            }
                        }
                        
                    case .changed:
                        updateQueue.async {
                            if let touchedObject = self.touchedObject,
                                var previousTouch = touchedObject.previousTouch{
                                
                                switch self.mode{
                                case .quaternion  :
                                    let currentTouch = self.sphereAnchor.simdConvertPosition(worldTouch, from: nil)
                                    previousTouch =  self.sphereAnchor.simdConvertPosition(previousTouch, from: nil)

                                    self.touchedObject?.rotate(from: previousTouch, to: currentTouch)
                                    self.touchedObject?.previousTouch = worldTouch
                                case .inertialHomegrown:
                                    let currentTouch = self.sphereAnchor.simdConvertPosition(worldTouch, from: nil)
                                    previousTouch =  self.sphereAnchor.simdConvertPosition(previousTouch, from: nil)
                                
                                    self.touchedObject?.applyTorque(from:
                                        previousTouch, to: currentTouch)
                                    self.touchedObject?.previousTouch = worldTouch
                                case .inertialApplePhysics:
                                    let oldWorldPosition = hit.node.simdConvertPosition(previousTouch, to: nil)
                                    let newWorldPosition = hit.node.simdConvertPosition(localTouch, to: nil)
                                    
                                    self.touchedObject?.previousTouch = localTouch
                                    self.sphereAnchor.applyTorque(startLocation: oldWorldPosition, endLocation: newWorldPosition)
                                    
                                    break
                                }
                            }
                        }
                    case .ended:
                        clear()
                    default: break
                    }
                    
                }else{
                    clear()
                }
    }
    
    /// Called when finger left the object
        /// or pan gesture eneded.
        /// we want to set prevoiousTouch to nil
        /// and angular acceleration to zero
        internal func clear(){
            updateQueue.async {
                self.touchedObject?.previousTouch = nil
                self.touchedObject?.simplePhysicsBody?.angularAcceleration = simd_float3()
            }
        }
}

/// Container for some useful extra variables
class VirtualObject: SCNNode{
    
    // keeps normalized location of previous touch
    var previousTouch: simd_float3?
    // simple homegrown physics body (when not using SCNPhysicsBody)
    var simplePhysicsBody: SimplePhysicsBody?
   
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyTorque(from previousTouch: simd_float3, to currentTouch: simd_float3){
        let previousTouch = simd_normalize(previousTouch)
        let currentTouch = simd_normalize(currentTouch)
        self.simplePhysicsBody?.applyTorque(from: previousTouch, to: currentTouch)
        //self.previousTouch = currentTouch
    }
    
    /// calculates and applies quaternion rotation between two vectors
    /// - parameter previousTouch: normalized previous touch
    /// - parameter currentTouch: normalized curent touch
    func rotate(from previousTouch: simd_float3, to currentTouch: simd_float3){
        //print("changed \(previousTouch) \(currentTouch)")
        let previousTouch = simd_normalize(previousTouch)
        let currentTouch = simd_normalize(currentTouch)
        //make sure to normalize axis to make unit quaternion
        let axis = simd_normalize(simd_cross(currentTouch, previousTouch))
        
        // sometimes dot product goes outside the the range of -1 to 1
        // keep it in the range
        let dot = max(min(1, simd_dot(currentTouch, previousTouch)), -1)
        
        let angle = acosf(dot)
        let rotation = simd_quaternion(-angle, axis)
        
        let length = rotation.length
        if !length.isNaN{
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.15
            self.simdOrientation = rotation * self.simdOrientation
            SCNTransaction.commit()
        }
        //self.previousTouch = currentTouch
    }
}

struct SimplePhysicsBody{
    
    var mass = Float(1.6)
    var radius = Float(0.1524)
    
    /// Moment of inertia for hollow sphere
    lazy var momentOfInertia: Float = {
        return (2 * mass * pow(radius, 2))/3
    }()
    
    var angularAcceleration = simd_float3()
    var angularVelocity = simd_float3()
    
    /// last time angularVelocity and angularAcceleration were updated
    var lastUpdated: TimeInterval?
    
    init(mass: Float, radius: Float){
        self.mass = mass
        self.radius = radius
        self.angularAcceleration = simd_float3()
        self.angularVelocity = simd_float3()
    }
    
    /// Calculates torque between two vectors
    /// - Parameters: normalized vectors
    ///
    /// - Returns: torque: simd_float3?
    func torque(from previousTouch: simd_float3, to currentTouch: simd_float3)->simd_float3?{
        
        let forceVector = currentTouch - previousTouch
        let leverArmVector = previousTouch
        let rotationAxis = simd_cross(leverArmVector, forceVector)
        if !simd_length(simd_normalize(rotationAxis)).isNaN{
            return rotationAxis
        }
        return nil
    }
    
    /// calculate torque and set angularAcceleration from it
    mutating func applyTorque(from previousTouch: simd_float3, to currentTouch: simd_float3){
        
        if let torque = self.torque(from: previousTouch, to: currentTouch){
            self.angularAcceleration  =  torque / self.momentOfInertia
        }
    }
    
    /// calculate rotation quaternion for time inteval from
    /// angular velocity and angular acceleration
    /// update angular velocity and angular accelertion to next value
    mutating func rotation(for time: TimeInterval)->simd_quatf?{
        var rotationQuaternion: simd_quatf?
        if let previousTime = self.lastUpdated{
            let timeInterval = Float(time - previousTime)
            
            // 1. Calculate new angular velocity
            var ω = self.angularVelocity
            //decay angular velocity by 2% in every frame
            ω -= ω * 0.02
            
            // apply angular aceleration
            if !simd_length(self.angularAcceleration).isZero {
                // calculate the fraction of angular acceleration
                // to be applied at this time interval, and
                // update angular velocity
                ω += self.angularAcceleration * timeInterval
            }
            //update to new angular velocity
            self.angularVelocity = ω
            
            // 2. use angular velocity
            // to create a unit quaternion representing
            // rotation in this time interval
            let ωl = simd_length(ω) // magnitude
            if !ωl.isNaN && !ωl.isZero{
                // unit quaternion has axis of length 1
                let axis = simd_normalize(ω)
                // calculate fraction of rotation
                // for this time interval
                let angle = ωl * timeInterval
                rotationQuaternion = simd_quaternion(angle, axis)
            }
        }
        // update time and simplePhysicsBody
        self.lastUpdated = time
        return rotationQuaternion
    }
}

extension SCNNode{
    // the Apple way
    func applyTorque(startLocation: simd_float3, endLocation: simd_float3){
        guard let physicsBody = self.physicsBody else{
            return
        }
        
        let nodeCenterWorld = self.simdConvertPosition(self.simdPosition, to: nil)
        let forceVector = endLocation - startLocation
        let leverArmVector = startLocation - nodeCenterWorld
        let rotationAxis = simd_cross(leverArmVector, forceVector)
        let magnitude = simd_length(rotationAxis)
        // torqueAxis is a unit vector
        var torqueAxis = simd_normalize(rotationAxis)
        if simd_length(torqueAxis).isNaN {
            return
        }
        
        let orientationQuaternion = self.presentation.simdOrientation
        // align torque axis with current orientation
        torqueAxis = orientationQuaternion.act(torqueAxis)
        let torque = SCNVector4(torqueAxis.x, torqueAxis.y, torqueAxis.z, magnitude)
        //print("torque \(torque)")
        physicsBody.applyTorque(torque, asImpulse: true)
    }
}
