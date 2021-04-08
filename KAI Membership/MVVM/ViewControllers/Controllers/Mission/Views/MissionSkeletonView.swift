//
//  MissionSkeletonView.swift
//  KAI Membership
//
//  Created by DAKiet on 29/03/2021.
//

import SkeletonView

class MissionSkeletonView: UIView {
    
    // MARK: Properties
    private let imageView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 26
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let titleView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
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
    
    private let imageView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 26
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let titleView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
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
    
    private let imageView3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 26
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let titleView3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
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
    
    private let imageView4: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 26
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let titleView4: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
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
    
    private let imageView5: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 26
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let titleView5: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
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
    
    private let imageView6: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 26
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let titleView6: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
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
    
    private let imageView7: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 26
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        return view
    }()
    
    private let titleView7: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
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
        
        addSubview(imageView1)
        addSubview(titleView1)
        addSubview(descriptionView1)
        
        addSubview(imageView2)
        addSubview(titleView2)
        addSubview(descriptionView2)
        
        addSubview(imageView3)
        addSubview(titleView3)
        addSubview(descriptionView3)
        
        addSubview(imageView4)
        addSubview(titleView4)
        addSubview(descriptionView4)
        
        addSubview(imageView5)
        addSubview(titleView5)
        addSubview(descriptionView5)
        
        addSubview(imageView6)
        addSubview(titleView6)
        addSubview(descriptionView6)
        
        addSubview(imageView7)
        addSubview(titleView7)
        addSubview(descriptionView7)
        
        NSLayoutConstraint.activate([
            imageView1.topAnchor.constraint(equalTo: topAnchor, constant: MissionHeaderView.height + 30),
            imageView1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            imageView1.widthAnchor.constraint(equalToConstant: 52),
            imageView1.heightAnchor.constraint(equalToConstant: 52),
            
            titleView1.topAnchor.constraint(equalTo: imageView1.topAnchor, constant: 5),
            titleView1.leadingAnchor.constraint(equalTo: imageView1.trailingAnchor, constant: 12),
            titleView1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            titleView1.heightAnchor.constraint(equalToConstant: 20),

            descriptionView1.topAnchor.constraint(equalTo: titleView1.bottomAnchor, constant: 4),
            descriptionView1.leadingAnchor.constraint(equalTo: titleView1.leadingAnchor),
            descriptionView1.trailingAnchor.constraint(equalTo: titleView1.trailingAnchor),
            descriptionView1.heightAnchor.constraint(equalToConstant: 18),
            
            imageView2.topAnchor.constraint(equalTo: imageView1.bottomAnchor, constant: 36),
            imageView2.leadingAnchor.constraint(equalTo: imageView1.leadingAnchor),
            imageView2.widthAnchor.constraint(equalToConstant: 52),
            imageView2.heightAnchor.constraint(equalToConstant: 52),
        
            titleView2.topAnchor.constraint(equalTo: imageView2.topAnchor, constant: 5),
            titleView2.leadingAnchor.constraint(equalTo: imageView2.trailingAnchor, constant: 12),
            titleView2.trailingAnchor.constraint(equalTo: titleView1.trailingAnchor),
            titleView2.heightAnchor.constraint(equalToConstant: 20),

            descriptionView2.topAnchor.constraint(equalTo: titleView2.bottomAnchor, constant: 4),
            descriptionView2.leadingAnchor.constraint(equalTo: titleView2.leadingAnchor),
            descriptionView2.trailingAnchor.constraint(equalTo: titleView2.trailingAnchor),
            descriptionView2.heightAnchor.constraint(equalToConstant: 18),
            
            imageView3.topAnchor.constraint(equalTo: imageView2.bottomAnchor, constant: 36),
            imageView3.leadingAnchor.constraint(equalTo: imageView1.leadingAnchor),
            imageView3.widthAnchor.constraint(equalToConstant: 52),
            imageView3.heightAnchor.constraint(equalToConstant: 52),
        
            titleView3.topAnchor.constraint(equalTo: imageView3.topAnchor, constant: 5),
            titleView3.leadingAnchor.constraint(equalTo: imageView3.trailingAnchor, constant: 12),
            titleView3.trailingAnchor.constraint(equalTo: titleView1.trailingAnchor),
            titleView3.heightAnchor.constraint(equalToConstant: 20),

            descriptionView3.topAnchor.constraint(equalTo: titleView3.bottomAnchor, constant: 4),
            descriptionView3.leadingAnchor.constraint(equalTo: titleView3.leadingAnchor),
            descriptionView3.trailingAnchor.constraint(equalTo: titleView3.trailingAnchor),
            descriptionView3.heightAnchor.constraint(equalToConstant: 18),
            
            imageView4.topAnchor.constraint(equalTo: imageView3.bottomAnchor, constant: 36),
            imageView4.leadingAnchor.constraint(equalTo: imageView1.leadingAnchor),
            imageView4.widthAnchor.constraint(equalToConstant: 52),
            imageView4.heightAnchor.constraint(equalToConstant: 52),
        
            titleView4.topAnchor.constraint(equalTo: imageView4.topAnchor, constant: 5),
            titleView4.leadingAnchor.constraint(equalTo: imageView4.trailingAnchor, constant: 12),
            titleView4.trailingAnchor.constraint(equalTo: titleView1.trailingAnchor),
            titleView4.heightAnchor.constraint(equalToConstant: 20),

            descriptionView4.topAnchor.constraint(equalTo: titleView4.bottomAnchor, constant: 4),
            descriptionView4.leadingAnchor.constraint(equalTo: titleView4.leadingAnchor),
            descriptionView4.trailingAnchor.constraint(equalTo: titleView4.trailingAnchor),
            descriptionView4.heightAnchor.constraint(equalToConstant: 18),
            
            imageView5.topAnchor.constraint(equalTo: imageView4.bottomAnchor, constant: 36),
            imageView5.leadingAnchor.constraint(equalTo: imageView1.leadingAnchor),
            imageView5.widthAnchor.constraint(equalToConstant: 52),
            imageView5.heightAnchor.constraint(equalToConstant: 52),
        
            titleView5.topAnchor.constraint(equalTo: imageView5.topAnchor, constant: 5),
            titleView5.leadingAnchor.constraint(equalTo: imageView5.trailingAnchor, constant: 12),
            titleView5.trailingAnchor.constraint(equalTo: titleView1.trailingAnchor),
            titleView5.heightAnchor.constraint(equalToConstant: 20),

            descriptionView5.topAnchor.constraint(equalTo: titleView5.bottomAnchor, constant: 4),
            descriptionView5.leadingAnchor.constraint(equalTo: titleView5.leadingAnchor),
            descriptionView5.trailingAnchor.constraint(equalTo: titleView5.trailingAnchor),
            descriptionView5.heightAnchor.constraint(equalToConstant: 18),
            
            imageView6.topAnchor.constraint(equalTo: imageView5.bottomAnchor, constant: 36),
            imageView6.leadingAnchor.constraint(equalTo: imageView1.leadingAnchor),
            imageView6.widthAnchor.constraint(equalToConstant: 52),
            imageView6.heightAnchor.constraint(equalToConstant: 52),
        
            titleView6.topAnchor.constraint(equalTo: imageView6.topAnchor, constant: 5),
            titleView6.leadingAnchor.constraint(equalTo: imageView6.trailingAnchor, constant: 12),
            titleView6.trailingAnchor.constraint(equalTo: titleView1.trailingAnchor),
            titleView6.heightAnchor.constraint(equalToConstant: 20),

            descriptionView6.topAnchor.constraint(equalTo: titleView6.bottomAnchor, constant: 4),
            descriptionView6.leadingAnchor.constraint(equalTo: titleView6.leadingAnchor),
            descriptionView6.trailingAnchor.constraint(equalTo: titleView6.trailingAnchor),
            descriptionView6.heightAnchor.constraint(equalToConstant: 18),
            
            imageView7.topAnchor.constraint(equalTo: imageView6.bottomAnchor, constant: 36),
            imageView7.leadingAnchor.constraint(equalTo: imageView1.leadingAnchor),
            imageView7.widthAnchor.constraint(equalToConstant: 52),
            imageView7.heightAnchor.constraint(equalToConstant: 52),
        
            titleView7.topAnchor.constraint(equalTo: imageView7.topAnchor, constant: 5),
            titleView7.leadingAnchor.constraint(equalTo: imageView7.trailingAnchor, constant: 12),
            titleView7.trailingAnchor.constraint(equalTo: titleView1.trailingAnchor),
            titleView7.heightAnchor.constraint(equalToConstant: 20),

            descriptionView7.topAnchor.constraint(equalTo: titleView7.bottomAnchor, constant: 4),
            descriptionView7.leadingAnchor.constraint(equalTo: titleView7.leadingAnchor),
            descriptionView7.trailingAnchor.constraint(equalTo: titleView7.trailingAnchor),
            descriptionView7.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
}
