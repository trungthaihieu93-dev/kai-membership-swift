//
//  WalletSkeletonView.swift
//  KAI Membership
//
//  Created by DAKiet on 29/03/2021.
//

import SkeletonView

class WalletSkeletonView: UIView {
    
    // MARK: Properties
    private let cardView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "bg_card"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 24
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let sectionTitleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let contentImageView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let titleView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let descriptionView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let contentImageView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let titleView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let descriptionView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let contentImageView3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let titleView3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let descriptionView3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let contentImageView4: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let titleView4: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let descriptionView4: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let contentImageView5: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let titleView5: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let descriptionView5: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let contentImageView6: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let titleView6: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let descriptionView6: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let contentImageView7: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let titleView7: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let descriptionView7: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let contentImageView8: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let titleView8: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let descriptionView8: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let contentImageView9: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let titleView9: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let descriptionView9: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
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
        
        addSubview(cardView)
        addSubview(sectionTitleView)
        
        addSubview(contentImageView1)
        addSubview(titleView1)
        addSubview(descriptionView1)
        
        addSubview(contentImageView2)
        addSubview(titleView2)
        addSubview(descriptionView2)
        
        addSubview(contentImageView3)
        addSubview(titleView3)
        addSubview(descriptionView3)
        
        addSubview(contentImageView4)
        addSubview(titleView4)
        addSubview(descriptionView4)
        
        addSubview(contentImageView5)
        addSubview(titleView5)
        addSubview(descriptionView5)
        
        addSubview(contentImageView6)
        addSubview(titleView6)
        addSubview(descriptionView6)
        
        addSubview(contentImageView7)
        addSubview(titleView7)
        addSubview(descriptionView7)
        
        addSubview(contentImageView8)
        addSubview(titleView8)
        addSubview(descriptionView8)
        
        addSubview(contentImageView9)
        addSubview(titleView9)
        addSubview(descriptionView9)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            cardView.heightAnchor.constraint(equalToConstant: cardView.frame.height),
            
            sectionTitleView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 30),
            sectionTitleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            sectionTitleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            sectionTitleView.heightAnchor.constraint(equalToConstant: 24),
            
            contentImageView1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentImageView1.widthAnchor.constraint(equalToConstant: 16),
            contentImageView1.heightAnchor.constraint(equalToConstant: 16),
            
            titleView1.topAnchor.constraint(equalTo: sectionTitleView.bottomAnchor, constant: 12),
            titleView1.centerYAnchor.constraint(equalTo: contentImageView1.centerYAnchor),
            titleView1.leadingAnchor.constraint(equalTo: contentImageView1.trailingAnchor, constant: 12),
            titleView1.widthAnchor.constraint(equalToConstant: 200),
            titleView1.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionView1.topAnchor.constraint(equalTo: titleView1.topAnchor),
            descriptionView1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            descriptionView1.widthAnchor.constraint(equalToConstant: 120),
            descriptionView1.heightAnchor.constraint(equalToConstant: 40),
            
            contentImageView2.leadingAnchor.constraint(equalTo: contentImageView1.leadingAnchor),
            contentImageView2.widthAnchor.constraint(equalToConstant: 16),
            contentImageView2.heightAnchor.constraint(equalToConstant: 16),
            
            titleView2.topAnchor.constraint(equalTo: titleView1.bottomAnchor, constant: 12),
            titleView2.centerYAnchor.constraint(equalTo: contentImageView2.centerYAnchor),
            titleView2.leadingAnchor.constraint(equalTo: contentImageView2.trailingAnchor, constant: 12),
            titleView2.widthAnchor.constraint(equalToConstant: 200),
            titleView2.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionView2.topAnchor.constraint(equalTo: titleView2.topAnchor),
            descriptionView2.trailingAnchor.constraint(equalTo: descriptionView1.trailingAnchor),
            descriptionView2.widthAnchor.constraint(equalToConstant: 120),
            descriptionView2.heightAnchor.constraint(equalToConstant: 40),
            
            contentImageView3.leadingAnchor.constraint(equalTo: contentImageView1.leadingAnchor),
            contentImageView3.widthAnchor.constraint(equalToConstant: 16),
            contentImageView3.heightAnchor.constraint(equalToConstant: 16),
            
            titleView3.topAnchor.constraint(equalTo: titleView2.bottomAnchor, constant: 12),
            titleView3.centerYAnchor.constraint(equalTo: contentImageView3.centerYAnchor),
            titleView3.leadingAnchor.constraint(equalTo: contentImageView3.trailingAnchor, constant: 12),
            titleView3.widthAnchor.constraint(equalToConstant: 200),
            titleView3.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionView3.topAnchor.constraint(equalTo: titleView3.topAnchor),
            descriptionView3.trailingAnchor.constraint(equalTo: descriptionView1.trailingAnchor),
            descriptionView3.widthAnchor.constraint(equalToConstant: 120),
            descriptionView3.heightAnchor.constraint(equalToConstant: 40),
            
            contentImageView4.leadingAnchor.constraint(equalTo: contentImageView1.leadingAnchor),
            contentImageView4.widthAnchor.constraint(equalToConstant: 16),
            contentImageView4.heightAnchor.constraint(equalToConstant: 16),
            
            titleView4.topAnchor.constraint(equalTo: titleView3.bottomAnchor, constant: 12),
            titleView4.centerYAnchor.constraint(equalTo: contentImageView4.centerYAnchor),
            titleView4.leadingAnchor.constraint(equalTo: contentImageView4.trailingAnchor, constant: 12),
            titleView4.widthAnchor.constraint(equalToConstant: 200),
            titleView4.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionView4.topAnchor.constraint(equalTo: titleView4.topAnchor),
            descriptionView4.trailingAnchor.constraint(equalTo: descriptionView1.trailingAnchor),
            descriptionView4.widthAnchor.constraint(equalToConstant: 120),
            descriptionView4.heightAnchor.constraint(equalToConstant: 40),
            
            contentImageView5.leadingAnchor.constraint(equalTo: contentImageView1.leadingAnchor),
            contentImageView5.widthAnchor.constraint(equalToConstant: 16),
            contentImageView5.heightAnchor.constraint(equalToConstant: 16),
            
            titleView5.topAnchor.constraint(equalTo: titleView4.bottomAnchor, constant: 12),
            titleView5.centerYAnchor.constraint(equalTo: contentImageView5.centerYAnchor),
            titleView5.leadingAnchor.constraint(equalTo: contentImageView5.trailingAnchor, constant: 12),
            titleView5.widthAnchor.constraint(equalToConstant: 200),
            titleView5.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionView5.topAnchor.constraint(equalTo: titleView5.topAnchor),
            descriptionView5.trailingAnchor.constraint(equalTo: descriptionView1.trailingAnchor),
            descriptionView5.widthAnchor.constraint(equalToConstant: 120),
            descriptionView5.heightAnchor.constraint(equalToConstant: 40),
            
            contentImageView6.leadingAnchor.constraint(equalTo: contentImageView1.leadingAnchor),
            contentImageView6.widthAnchor.constraint(equalToConstant: 16),
            contentImageView6.heightAnchor.constraint(equalToConstant: 16),
            
            titleView6.topAnchor.constraint(equalTo: titleView5.bottomAnchor, constant: 12),
            titleView6.centerYAnchor.constraint(equalTo: contentImageView6.centerYAnchor),
            titleView6.leadingAnchor.constraint(equalTo: contentImageView6.trailingAnchor, constant: 12),
            titleView6.widthAnchor.constraint(equalToConstant: 200),
            titleView6.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionView6.topAnchor.constraint(equalTo: titleView6.topAnchor),
            descriptionView6.trailingAnchor.constraint(equalTo: descriptionView1.trailingAnchor),
            descriptionView6.widthAnchor.constraint(equalToConstant: 120),
            descriptionView6.heightAnchor.constraint(equalToConstant: 40),
            
            contentImageView7.leadingAnchor.constraint(equalTo: contentImageView1.leadingAnchor),
            contentImageView7.widthAnchor.constraint(equalToConstant: 16),
            contentImageView7.heightAnchor.constraint(equalToConstant: 16),
            
            titleView7.topAnchor.constraint(equalTo: titleView6.bottomAnchor, constant: 12),
            titleView7.centerYAnchor.constraint(equalTo: contentImageView7.centerYAnchor),
            titleView7.leadingAnchor.constraint(equalTo: contentImageView7.trailingAnchor, constant: 12),
            titleView7.widthAnchor.constraint(equalToConstant: 200),
            titleView7.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionView7.topAnchor.constraint(equalTo: titleView7.topAnchor),
            descriptionView7.trailingAnchor.constraint(equalTo: descriptionView1.trailingAnchor),
            descriptionView7.widthAnchor.constraint(equalToConstant: 120),
            descriptionView7.heightAnchor.constraint(equalToConstant: 40),
            
            contentImageView8.leadingAnchor.constraint(equalTo: contentImageView1.leadingAnchor),
            contentImageView8.widthAnchor.constraint(equalToConstant: 16),
            contentImageView8.heightAnchor.constraint(equalToConstant: 16),
            
            titleView8.topAnchor.constraint(equalTo: titleView7.bottomAnchor, constant: 12),
            titleView8.centerYAnchor.constraint(equalTo: contentImageView8.centerYAnchor),
            titleView8.leadingAnchor.constraint(equalTo: contentImageView8.trailingAnchor, constant: 12),
            titleView8.widthAnchor.constraint(equalToConstant: 200),
            titleView8.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionView8.topAnchor.constraint(equalTo: titleView8.topAnchor),
            descriptionView8.trailingAnchor.constraint(equalTo: descriptionView1.trailingAnchor),
            descriptionView8.widthAnchor.constraint(equalToConstant: 120),
            descriptionView8.heightAnchor.constraint(equalToConstant: 40),
            
            contentImageView9.leadingAnchor.constraint(equalTo: contentImageView1.leadingAnchor),
            contentImageView9.widthAnchor.constraint(equalToConstant: 16),
            contentImageView9.heightAnchor.constraint(equalToConstant: 16),
            
            titleView9.topAnchor.constraint(equalTo: titleView8.bottomAnchor, constant: 12),
            titleView9.centerYAnchor.constraint(equalTo: contentImageView9.centerYAnchor),
            titleView9.leadingAnchor.constraint(equalTo: contentImageView9.trailingAnchor, constant: 12),
            titleView9.widthAnchor.constraint(equalToConstant: 200),
            titleView9.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionView9.topAnchor.constraint(equalTo: titleView9.topAnchor),
            descriptionView9.trailingAnchor.constraint(equalTo: descriptionView1.trailingAnchor),
            descriptionView9.widthAnchor.constraint(equalToConstant: 120),
            descriptionView9.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

