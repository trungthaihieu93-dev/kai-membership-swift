//
//  NewsSkeletonView.swift
//  KAI Membership
//
//  Created by DAKiet on 26/03/2021.
//

import SkeletonView

class NewsSkeletonView: UIView {
    
    // MARK: Properties
    private let suggestView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let suggestView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let lastestTitleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let lastestImageView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let lastestTitleView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let lastestImageView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let lastestTitleView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let lastestImageView3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let lastestTitleView3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let lastestImageView4: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let lastestImageView5: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let lastestImageView6: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    // MARK: Life cycle's
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    func setupView() {
        backgroundColor = Constants.backroundColorDefault
        addSubview(suggestView1)
        addSubview(suggestView2)
        
        addSubview(lastestTitleView)
        
        addSubview(lastestImageView1)
        addSubview(lastestTitleView1)
        addSubview(lastestImageView4)
        
        addSubview(lastestImageView2)
        addSubview(lastestTitleView2)
        addSubview(lastestImageView5)
        
        addSubview(lastestImageView3)
        addSubview(lastestTitleView3)
        addSubview(lastestImageView6)
        
        NSLayoutConstraint.activate([
            suggestView1.topAnchor.constraint(equalTo: topAnchor),
            suggestView1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            suggestView1.widthAnchor.constraint(equalToConstant: NewsSuggestionTableViewCell.itemSize.width),
            suggestView1.heightAnchor.constraint(equalToConstant: NewsSuggestionTableViewCell.itemSize.height),
            
            suggestView2.topAnchor.constraint(equalTo: suggestView1.topAnchor),
            suggestView2.leadingAnchor.constraint(equalTo: suggestView1.trailingAnchor, constant: 20),
            suggestView2.widthAnchor.constraint(equalTo: suggestView1.widthAnchor),
            suggestView2.heightAnchor.constraint(equalTo: suggestView1.heightAnchor),
            
            lastestTitleView.topAnchor.constraint(equalTo: suggestView1.bottomAnchor, constant: 22),
            lastestTitleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lastestTitleView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -20),
            lastestTitleView.heightAnchor.constraint(equalToConstant: 20),
            
            lastestImageView1.topAnchor.constraint(equalTo: lastestTitleView.bottomAnchor, constant: 22),
            lastestImageView1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            lastestImageView1.widthAnchor.constraint(equalToConstant: 64),
            lastestImageView1.heightAnchor.constraint(equalToConstant: 64),
            
            lastestTitleView1.topAnchor.constraint(equalTo: lastestImageView1.topAnchor),
            lastestTitleView1.leadingAnchor.constraint(equalTo: lastestImageView1.trailingAnchor, constant: 12),
            lastestTitleView1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            lastestTitleView1.heightAnchor.constraint(equalToConstant: 40),
            
            lastestImageView4.topAnchor.constraint(equalTo: lastestImageView1.topAnchor),
            lastestImageView4.leadingAnchor.constraint(equalTo: lastestTitleView1.trailingAnchor, constant: 12),
            lastestImageView4.widthAnchor.constraint(equalTo: lastestImageView1.widthAnchor),
            lastestImageView4.heightAnchor.constraint(equalTo: lastestImageView1.heightAnchor),
            
            lastestImageView2.topAnchor.constraint(equalTo: lastestImageView1.bottomAnchor, constant: 20),
            lastestImageView2.leadingAnchor.constraint(equalTo: lastestImageView1.leadingAnchor),
            lastestImageView2.widthAnchor.constraint(equalTo: lastestImageView1.widthAnchor),
            lastestImageView2.heightAnchor.constraint(equalTo: lastestImageView1.heightAnchor),
            
            lastestTitleView2.topAnchor.constraint(equalTo: lastestImageView2.topAnchor),
            lastestTitleView2.leadingAnchor.constraint(equalTo: lastestImageView2.trailingAnchor, constant: 12),
            lastestTitleView2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            lastestTitleView2.heightAnchor.constraint(equalToConstant: 40),
            
            lastestImageView5.topAnchor.constraint(equalTo: lastestImageView2.topAnchor),
            lastestImageView5.leadingAnchor.constraint(equalTo: lastestTitleView2.trailingAnchor, constant: 12),
            lastestImageView5.widthAnchor.constraint(equalTo: lastestImageView2.widthAnchor),
            lastestImageView5.heightAnchor.constraint(equalTo: lastestImageView2.heightAnchor),
            
            lastestImageView3.topAnchor.constraint(equalTo: lastestImageView2.bottomAnchor, constant: 20),
            lastestImageView3.leadingAnchor.constraint(equalTo: lastestImageView1.leadingAnchor),
            lastestImageView3.widthAnchor.constraint(equalTo: lastestImageView1.widthAnchor),
            lastestImageView3.heightAnchor.constraint(equalTo: lastestImageView1.heightAnchor),
            
            lastestTitleView3.topAnchor.constraint(equalTo: lastestImageView3.topAnchor),
            lastestTitleView3.leadingAnchor.constraint(equalTo: lastestImageView3.trailingAnchor, constant: 12),
            lastestTitleView3.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            lastestTitleView3.heightAnchor.constraint(equalToConstant: 40),
            
            lastestImageView6.topAnchor.constraint(equalTo: lastestImageView3.topAnchor),
            lastestImageView6.leadingAnchor.constraint(equalTo: lastestTitleView3.trailingAnchor, constant: 12),
            lastestImageView6.widthAnchor.constraint(equalTo: lastestImageView1.widthAnchor),
            lastestImageView6.heightAnchor.constraint(equalTo: lastestImageView1.heightAnchor),
        ])
    }
}
