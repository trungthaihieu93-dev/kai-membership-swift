//
//  WebViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 14/03/2021.
//

import UIKit
import WebKit

class WebViewController: BaseViewController {
    
    // MARK: Properties
    let url: URL
    
    private let webView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.allowsLinkPreview = false
        view.allowsBackForwardNavigationGestures = false
        
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_delete"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(onPressedCloseButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: Life cycle's
    init(with url: URL) {
        self.url = url
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        view.addSubview(closeButton)
        
        let views = [
            "close": closeButton,
            "web": webView
        ]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[close(40)]|", options: [.alignAllLeading], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[close(40)]-[web]|", options: [], metrics: ["top": safeAreaInsets.top], views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[web]|", options: [], metrics: nil, views: views))
        
        webView.load(URLRequest(url: url))
    }
    
    // MARK: Handle actions
    @objc private func onPressedCloseButton() {
        dismiss(animated: true, completion: nil)
    }
}
