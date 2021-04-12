//
//  NFTProgressView.swift
//  KAI Membership
//
//  Created by DAKiet on 12/04/2021.
//

import UIKit

class NFTProgressView: UIView {
    
    // MARK: Properties
    private let progressBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(hex: "283A5B")
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        
        return view
    }()
    
    private let progressTopView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(hex: "5AD0F8")
//        view.layer.cornerRadius = 4
//        view.layer.maskedCorners = [.layerMaxXMinYCorner]
        
        return view
    }()
    
    private let progressBottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(hex: "409EF1")
//        view.layer.cornerRadius = 4
//        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ic_cover_level"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let levelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 18, weight: .black)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    // MARK: Life cycle's
    init(level: Int = 0, currentExp: Double? = nil, totalExp: Double? = nil, frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupView()
        configure(level: level, currentExp: currentExp, totalExp: totalExp)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func setupView() {
        addSubview(progressBarView)
        progressBarView.addSubview(progressTopView)
        progressBarView.addSubview(progressBottomView)
        
        addSubview(imageView)
        addSubview(levelLabel)
        addSubview(progressLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 46),
            imageView.heightAnchor.constraint(equalToConstant: 46),
            
            progressBarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
            progressBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressBarView.centerYAnchor.constraint(equalTo: centerYAnchor),
            progressBarView.heightAnchor.constraint(equalToConstant: 32),
            
            progressTopView.topAnchor.constraint(equalTo: progressBarView.topAnchor),
            progressTopView.leadingAnchor.constraint(equalTo: progressBarView.leadingAnchor),
            progressTopView.heightAnchor.constraint(equalTo: progressBarView.heightAnchor, multiplier: 1 / 2),
            progressTopView.widthAnchor.constraint(equalTo: progressBarView.widthAnchor, multiplier: 0),
            
            progressBottomView.topAnchor.constraint(equalTo: progressTopView.bottomAnchor),
            progressBottomView.leadingAnchor.constraint(equalTo: progressTopView.leadingAnchor),
            progressBottomView.bottomAnchor.constraint(equalTo: progressBarView.bottomAnchor),
            progressBottomView.trailingAnchor.constraint(equalTo: progressTopView.trailingAnchor),
            
            levelLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 4),
            levelLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 4),
            levelLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -4),
            levelLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0),
            
            progressLabel.topAnchor.constraint(equalTo: progressBarView.topAnchor),
            progressLabel.bottomAnchor.constraint(equalTo: progressBarView.bottomAnchor),
            progressLabel.centerXAnchor.constraint(equalTo: progressBarView.centerXAnchor),
            progressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 46),
        ])
    }
    
    // MARK: Configure
    func configure(level: Int = 0, currentExp: Double? = nil, totalExp: Double? = nil) {
        let currentExp = currentExp ?? 0
        let totalExp = totalExp ?? 0
        progressLabel.text = "\(currentExp.formatToString())/\(totalExp.formatToString())"
        levelLabel.text = "\(level)"
        NSLayoutConstraint.deactivate([progressTopView.widthAnchor.constraint(equalTo: progressBarView.widthAnchor, multiplier: 0)])
        NSLayoutConstraint.activate([progressTopView.widthAnchor.constraint(equalTo: progressBarView.widthAnchor, multiplier: CGFloat(currentExp / totalExp))])
    }
}
