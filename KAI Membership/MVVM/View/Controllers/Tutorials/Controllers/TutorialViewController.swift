//
//  TutorialViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import UIKit

class TutorialViewController: BaseViewController {

    // MARK: Properties
    enum ActionStatus {
        case normal
        case trial
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        return scrollView
    }()
    
    private let actionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 3
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = .init(hex: "181E25")
        pageControl.pageIndicatorTintColor = .init(hex: "E6EAEF")
        
        if #available(iOS 14.0, *) {
            pageControl.setIndicatorImage(currentIndicatorImage, forPage: currentPageIndex)
        } else {
            // Fallback on earlier versions
        }
        
        return pageControl
    }()
    
    private let currentIndicatorImage: UIImage = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 16, height: 9)))
        view.backgroundColor = .init(hex: "181E25")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4.5
        
        let renderer = UIGraphicsImageRenderer(bounds: view.frame)

        return renderer.image { ctx in
            view.layer.render(in: ctx.cgContext)
        }
    }()
    
    private let indicatorImage: UIImage = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 9, height: 9)))
        view.backgroundColor = .init(hex: "E6EAEF")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4.5
        
        let renderer = UIGraphicsImageRenderer(bounds: view.frame)

        return renderer.image { ctx in
            view.layer.render(in: ctx.cgContext)
        }
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_right_arrow"), for: .normal)
        button.tintColor = .white
        button.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.backgroundColor = .init(hex: "181E25")
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(onPressedNext), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var trialButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.backgroundColor = .white
        button.setAttributedTitle(NSAttributedString(string: "Let me take a tour", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 16, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.87)
        ]), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.init(hex: "C9CED6").cgColor
        button.addTarget(self, action: #selector(onPressedTrail), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(onPressedSignIn), for: .touchUpInside)
        
        return button
    }()
    
    private let tutorialView1: TutorialView = {
        let view = TutorialView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(image: nil, title: "KAI membership", body: "A flagship application pushing the frontier of mass adoption. A super app for the general public to earn, store, spend, and invest KAI, focusing on user experience and utilities.")
        
        return view
    }()
    
    private let tutorialView2: TutorialView = {
        let view = TutorialView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(image: nil, title: "Play & Earn", body: "Sign in to entertain with plenty of interesting games and receive real KAI, mobile cards, and many lucky gifts.")
        
        return view
    }()
    
    private let tutorialView3: TutorialView = {
        let view = TutorialView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(image: nil, title: "Social Mining", body: "Contribute your unlimited creativity and complete the tokenized project missions to receive KAI rewards.")
        
        return view
    }()
    
    var lastContentOffsetX: CGFloat = 0
    var currentPageIndex: Int = 0 {
        didSet {
            guard currentPageIndex != oldValue else { return }
            
            pageControl.currentPage = currentPageIndex
            
            if #available(iOS 14.0, *) {
                pageControl.setIndicatorImage(nil, forPage: oldValue)
                pageControl.setIndicatorImage(currentIndicatorImage, forPage: currentPageIndex)
                pageControl.currentPageIndicatorTintColor = .init(hex: "181E25")
                pageControl.pageIndicatorTintColor = .init(hex: "E6EAEF")
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    private(set) var preCurrentPageIndex: Int = 0
    private var actionStatus: ActionStatus = .normal {
        didSet {
            switch actionStatus {
            case .normal:
                trialButton.isHidden = true
                signInButton.isHidden = true
                
                pageControl.isHidden = false
                nextButton.isHidden = false
            case .trial:
                pageControl.isHidden = true
                nextButton.isHidden = true
                
                trialButton.isHidden = false
                signInButton.isHidden = false
            }
        }
    }
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: Layout
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        view.addSubview(actionView)
        
        scrollView.addSubview(tutorialView1)
        scrollView.addSubview(tutorialView2)
        scrollView.addSubview(tutorialView3)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -safeAreaInsets.bottom),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            actionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            actionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            actionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tutorialView1.topAnchor.constraint(equalTo: scrollView.topAnchor),
            tutorialView1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            tutorialView1.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            tutorialView1.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            tutorialView1.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            tutorialView2.topAnchor.constraint(equalTo: scrollView.topAnchor),
            tutorialView2.leadingAnchor.constraint(equalTo: tutorialView1.trailingAnchor),
            tutorialView2.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            tutorialView2.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            tutorialView2.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            tutorialView3.topAnchor.constraint(equalTo: scrollView.topAnchor),
            tutorialView3.leadingAnchor.constraint(equalTo: tutorialView2.trailingAnchor),
            tutorialView3.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            tutorialView3.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            tutorialView3.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            tutorialView3.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        setupActionView()
        DispatchQueue.main.async {
            self.signInButton.gradientBackgroundColors([UIColor.init(hex: "394656").cgColor, UIColor.init(hex: "181E25").cgColor], direction: .vertical)
        }
    }
    
    private func setupActionView() {
        actionView.addSubview(pageControl)
        actionView.addSubview(nextButton)
        
        actionView.addSubview(trialButton)
        actionView.addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            nextButton.trailingAnchor.constraint(equalTo: actionView.trailingAnchor, constant: -32),
            nextButton.bottomAnchor.constraint(equalTo: actionView.bottomAnchor, constant: -32),
            nextButton.widthAnchor.constraint(equalToConstant: 48),
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            
            pageControl.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor),
            pageControl.leadingAnchor.constraint(equalTo: actionView.leadingAnchor, constant: 32),
            pageControl.trailingAnchor.constraint(lessThanOrEqualTo: nextButton.leadingAnchor, constant: -8),
            
            trialButton.topAnchor.constraint(equalTo: actionView.topAnchor),
            trialButton.leadingAnchor.constraint(equalTo: actionView.leadingAnchor, constant: 32),
            trialButton.trailingAnchor.constraint(equalTo: actionView.trailingAnchor, constant: -32),
            trialButton.heightAnchor.constraint(equalToConstant: 52),
            
            signInButton.topAnchor.constraint(equalTo: trialButton.bottomAnchor, constant: 12),
            signInButton.leadingAnchor.constraint(equalTo: trialButton.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: trialButton.trailingAnchor),
            signInButton.bottomAnchor.constraint(equalTo: actionView.bottomAnchor, constant: -24),
            signInButton.heightAnchor.constraint(equalTo: trialButton.heightAnchor)
        ])
    }
}

// MARK: Handle actions
extension TutorialViewController {
 
    @objc private func onPressedNext() {
        if currentPageIndex == pageControl.numberOfPages - 2 {
            actionStatus = .trial
            currentPageIndex = 2
        } else {
            currentPageIndex = 1
        }
        
        var offset = scrollView.contentOffset
        offset.x = view.frame.width * CGFloat(currentPageIndex)
        scrollView.setContentOffset(offset, animated: true)
    }
    
    @objc private func onPressedTrail() {
        Navigator.window?.rootViewController = RootTabbarController()
    }
    
    @objc private func onPressedSignIn() {
        Navigator.navigateToSignInVC(from: self)
    }
}

// MARK: UIScrollViewDelegate
extension TutorialViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastContentOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
         
        if lastContentOffsetX < x { // Right
            let newIndex = Int((x - 1) / view.frame.width) + 1
            currentPageIndex = newIndex
        } else { // Left
            let newIndex = Int((x + 1) / view.frame.width)
            currentPageIndex = newIndex
        }
    }
}
