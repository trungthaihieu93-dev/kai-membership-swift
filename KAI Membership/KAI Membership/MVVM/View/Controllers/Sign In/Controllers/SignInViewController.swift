//
//  SignInViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 19/02/2021.
//

import UIKit

class SignInViewController: BaseViewController {

    // MARK: Properties
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.black.withAlphaComponent(0.54)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        return label
    }()
    
    override var pageTitle: String {
        return "Welcome!"
    }
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: pageTitleHeight),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,  constant: -20),
        ])
        
        descriptionLabel.text = "Sign in and start our journey with KAI."
    }
}
