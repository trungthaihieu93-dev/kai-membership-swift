//
//  QuestHeaderView.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 04/03/2021.
//

import UIKit

class QuestHeaderView: UIView {
    
    // MARK: Properties
    private let coverImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bg_mission"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "image_mission"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.attributedText = NSAttributedString(string: "Mission", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 36, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.attributedText = NSAttributedString(string: "01 spin for every finished mission. Get it now!", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 16, weight: .semiBold),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        
        return label
    }()
    
    private(set) lazy var segmentView: UISegmentedControl = {
        let view = UISegmentedControl(items: ["Daily mission", "Monthly mission"])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(hex: "F7F8F9")
        view.selectedSegmentIndex = 0
        view.setWidth(115, forSegmentAt: 0)
        view.setWidth(136, forSegmentAt: 1)
        view.apportionsSegmentWidthsByContent = true
        view.layer.cornerRadius = 12
        view.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        
        return view
    }()
    
    var selectedSegmentIndexChanged: ((Int) -> Void)?
    
    // MARK: Life cycle's
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    func setupView() {
        backgroundColor = .init(hex: "F7F8F9")
        
        addSubview(coverImageView)
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(descriptionLabel)
        addSubview(segmentView)

        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 44),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 157),
            
            segmentView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            segmentView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
            segmentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            segmentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            segmentView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: Configure
    func configure() {
        
    }
    
    // MARK: Handle actions
    @objc private func segmentedValueChanged(_ sender: UISegmentedControl) {
        selectedSegmentIndexChanged?(sender.selectedSegmentIndex)
    }
}
