//
//  BuyViewController.swift
//  KAI Membership
//
//  Created by KAISER on 16/03/2021.
//

import UIKit

class BuyViewController : BaseViewController {
    
    private let closeButton : UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(named: "ic_close"), for: .normal)
        
        return view
    }()
    
    private let titleLabel : UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.workSansFont(ofSize: 36, weight: .regular)
        view.textColor = .black
        view.text = "Buy"
        
        return view
    }()
    
    private let firstImageView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_nami")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private let secondImageView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_kardiachain")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private let separatorImageView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "ic_partner")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private let introduceLabel : UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = UIColor.init(hex: "0A1F44")
        view.font = UIFont.workSansFont(ofSize: 20, weight: .medium)
        view.numberOfLines = 0
        
        return view
    }()
    
    private let descriptionLabel : UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.54)
        view.font = UIFont.workSansFont(ofSize: 14, weight: .medium)
        view.numberOfLines = 0
        
        return view
    }()
    
    private let downloadButton : UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Download Nami from Appstore", for: .normal)
        view.setTitleColor(UIColor.init(hex: "000000").withAlphaComponent(0.87), for: .normal)
        view.titleLabel?.font = UIFont.workSansFont(ofSize: 16, weight: .medium)
        view.backgroundColor = UIColor.white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(hex: "C9CED6").cgColor
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private let openButton : UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Open Nami", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont.workSansFont(ofSize: 16, weight: .medium)
        view.backgroundColor = UIColor.init(hex: "394656")
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visualize()
        bind()
        addTargets()
    }
}

extension BuyViewController {
    private func visualize() {
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(firstImageView)
        view.addSubview(separatorImageView)
        view.addSubview(secondImageView)
        view.addSubview(introduceLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(downloadButton)
        view.addSubview(openButton)
        
        let views = [
            "close" : closeButton,
            "title" : titleLabel,
            "firstImage" : firstImageView,
            "separator" : separatorImageView,
            "secondImage" : secondImageView,
            "introduce" : introduceLabel,
            "description" : descriptionLabel,
            "download" : downloadButton,
            "open" : openButton
        ]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[close(32)]-6-[title]-100-[firstImage(54)]-40-[introduce]-[description]-(>=8@999)-[download(52)]-12-[open(52)]-66-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[separator(14)]", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[separator(14)]", options: [], metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[title]-20-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[close(32)]-20-|", options: [], metrics: nil, views: views))
        
        view.addConstraint(NSLayoutConstraint(item: firstImageView, attribute: .width, relatedBy: .equal, toItem: firstImageView, attribute: .height, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: firstImageView, attribute: .width, relatedBy: .equal, toItem: secondImageView, attribute: .width, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: secondImageView, attribute: .width, relatedBy: .equal, toItem: secondImageView, attribute: .height, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: separatorImageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[separator]-48-[secondImage]", options: [.alignAllCenterY], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[firstImage]-48-[separator]", options: [.alignAllCenterY], metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[introduce]-20-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[description]-20-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[download]-20-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[open]-20-|", options: [], metrics: nil, views: views))
    }
    
    private func bind() {
        introduceLabel.text = "Nami Exchange - Crypto Futures"
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.71
        paragraphStyle.alignment = .center
        
        var text = NSMutableAttributedString(string: "In order to ensure trading security, we must process through our partner's platform.\nPlease open ", attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        
        let middleFix = NSMutableAttributedString(string: "Nami Exchange - Crypto Futures", attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.foregroundColor : UIColor(red: 178/255, green: 58/255, blue: 36/255, alpha: 1.0),
        ])
        text.append(middleFix)
        
        let suffix = NSMutableAttributedString(string: " so we can progress faster.", attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        text.append(suffix)
        
        descriptionLabel.attributedText = text
    }
    
    private func addTargets() {
        closeButton.addTarget(self, action: #selector(tapCloseButton), for: .touchUpInside)
        downloadButton.addTarget(self, action: #selector(tapDownloadButton), for: .touchUpInside)
        openButton.addTarget(self, action: #selector(tapOpenButton), for: .touchUpInside)
    }
    
    @objc private func tapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func tapDownloadButton() {
        
    }
    
    @objc private func tapOpenButton() {
        
    }
}

