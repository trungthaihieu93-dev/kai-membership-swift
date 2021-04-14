//
//  KaiStarterDetailMediaTableViewCell.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 13/04/2021.
//

import UIKit

class KaiStarterDetailMediaTableViewCell: UITableViewCell {
    
    // MARK: Properties
    private let sectionInset: UIEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 20)
    
    private let itemSize: CGSize = CGSize(width: 107, height: 60)
    
    private var kaiProjects: [KaiProjectRemote] = []
    
    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        
        return imageView
    }()
    
    private lazy var youtubePlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_button_play_youtu")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(onPressedYoutuPlayButton), for: .touchUpOutside)
        
        return button
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = HorizontalPagingCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
//        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.sectionInset = sectionInset
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = false
        view.decelerationRate = .fast
        view.register(KaiStarterCollectionViewCell.self, forCellWithReuseIdentifier: KaiStarterCollectionViewCell.identifier)
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    // MARK: Life cycle's
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(bannerImageView)
        contentView.addSubview(youtubePlayButton)
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            bannerImageView.heightAnchor.constraint(equalTo: bannerImageView.widthAnchor, multiplier: 210 / 374),

            youtubePlayButton.centerXAnchor.constraint(equalTo: bannerImageView.centerXAnchor),
            youtubePlayButton.centerYAnchor.constraint(equalTo: bannerImageView.centerYAnchor),
            youtubePlayButton.widthAnchor.constraint(equalToConstant: 48),
            youtubePlayButton.heightAnchor.constraint(equalToConstant: 33.61),
            
            collectionView.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 2),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: itemSize.height),
        ])
    }
    
    // MARK: Layout
    func reloadWithData(_ kaiProjects: [KaiProjectRemote]) {
        self.kaiProjects = kaiProjects
        collectionView.reloadData()
    }
    
    // MARK: Handle actions
    @objc private func onPressedYoutuPlayButton() {
        
    }
}

// MARK: UICollectionViewDataSource
extension KaiStarterDetailMediaTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kaiProjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KaiStarterCollectionViewCell.identifier, for: indexPath) as! KaiStarterCollectionViewCell
        cell.configure(with: kaiProjects[indexPath.row])
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension KaiStarterDetailMediaTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
