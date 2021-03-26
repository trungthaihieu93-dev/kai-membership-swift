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
    private let iSafeAreaLayout: Bool
    
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
        button.setImage(UIImage(named: "ic_delete")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.createShadow(radius: 8)
        button.addTarget(self, action: #selector(onPressedClose), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: Life cycle's
    init(with url: URL, iSafeAreaLayout: Bool = false, isMultipleTouchEnabled: Bool = true) {
        self.url = url
        self.iSafeAreaLayout = iSafeAreaLayout
        
        super.init(nibName: nil, bundle: nil)
        
        webView.isMultipleTouchEnabled = isMultipleTouchEnabled
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: iSafeAreaLayout ? (statusBarHeight + 44) : 0),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: statusBarHeight),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 32),
            closeButton.heightAnchor.constraint(equalToConstant: 32),
        ])
        
        webView.load(URLRequest(url: url))
        webView.navigationDelegate = self
    }
    
    // MARK: Handle actions
    @objc private func onPressedClose() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
}
