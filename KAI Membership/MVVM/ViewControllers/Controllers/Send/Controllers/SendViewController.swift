//
//  SendViewController.swift
//  KAI Membership
//
//  Created by DAKiet on 17/03/2021.
//

import UIKit

class SendViewController: BaseViewController {

    // MARK: Properties
    enum Section: Int, CaseIterable {
        case info
        case setting
    }
    
    let viewModel = SendViewModel()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0.01, height: 0.01))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0.01, height: 0.01))
        tableView.backgroundColor = Constants.backroundColorDefault
        tableView.contentInset = .init(top: 0, left: 0, bottom: safeAreaInsets.bottom, right: 0)
        tableView.register(CardCollapseTableViewCell.self, forCellReuseIdentifier: CardCollapseTableViewCell.identifier)
        tableView.register(SendTableViewCell.self, forCellReuseIdentifier: SendTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(NSAttributedString(string: "Continue", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 16, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]), for: .normal)
        button.isEnabled = false
        button.backgroundColor = .init(hex: "E1E4E8")
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(onPressedSend), for: .touchUpInside)
        
        return button
    }()
    
    private var continueButtonBottomAnchor: NSLayoutConstraint?
    
    var isConfirmEnabled: Bool = false {
        didSet {
            guard isConfirmEnabled != oldValue else { return }
            
            continueButton.isEnabled = isConfirmEnabled
            
            if isConfirmEnabled {
                continueButton.gradientBackgroundColors([UIColor.init(hex: "394656").cgColor, UIColor.init(hex: "181E25").cgColor], direction: .vertical)
            } else {
                continueButton.removeAllSublayers(withName: UIView.gradientLayerKey)
            }
        }
    }
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        navigationItem.title = "Send"
        setupView()
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTap(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.cancelsTouchesInView = true
        tableView.addGestureRecognizer(singleTap)
    }
    
    private lazy var cameraButton2: UIButton = {
        let button = UIButton(type: .system)
        button.frame.size = CGSize(width: 32, height: 32)
        button.setImage(UIImage(named: "ic_delete")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.createShadow(radius: 8)
        
        return button
    }()
    
    // MARK: Layout
    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            continueButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 52),
        ])
        
        continueButtonBottomAnchor = continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(safeAreaInsets.bottom + 20))
        continueButtonBottomAnchor?.isActive = true
    }
}

// MARK: Handle actions
extension SendViewController {
    
    @objc private func handleSingleTap(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc private func onPressedClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func onPressedSend() {
        Navigator.navigateToOverviewVC(from: self, address: viewModel.walletAddress, amount: viewModel.amount)
        view.endEditing(true)
    }
    
    @objc private func handleKeyboardNotification(_ notification: NSNotification) {
        if notification.name == UIResponder.keyboardWillShowNotification {
            guard let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            continueButtonBottomAnchor?.constant = -(keyboardFrame.height + 20)
        } else {
            continueButtonBottomAnchor?.constant = -(safeAreaInsets.bottom + 20)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
