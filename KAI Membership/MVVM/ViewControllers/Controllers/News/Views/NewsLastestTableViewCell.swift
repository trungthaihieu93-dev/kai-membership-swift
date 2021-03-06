//
//  NewsLastestTableViewCell.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 04/03/2021.
//

import UIKit

class NewsLastestTableViewCell: UITableViewCell {
    
    // MARK: Properties
    static let height: CGFloat = 252
    
    private let minimumInteritemSpacing: CGFloat = 20
    private let sectionInset: UIEdgeInsets = .init(top: 0, left: 20, bottom: 20, right: 20)
    
    private var lastests = [TwitterNews]()
    
    private var images = [
        UIImage(named: "news_8")?.resizeImage(newWidth: 64 * 4),
        UIImage(named: "news_9")?.resizeImage(newWidth: 64 * 4),
        UIImage(named: "news_10")?.resizeImage(newWidth: 64 * 4),
        UIImage(named: "news_11")?.resizeImage(newWidth: 64 * 4),
        UIImage(named: "news_12")?.resizeImage(newWidth: 64 * 4),
        UIImage(named: "news_13")?.resizeImage(newWidth: 64 * 4),
        UIImage(named: "news_14")?.resizeImage(newWidth: 64 * 4)
    ]
    
    private lazy var itemSize: CGSize = {
        let width: CGFloat = collectionView.frame.width - (sectionInset.left + sectionInset.right)
        let height: CGFloat = ((NewsLastestTableViewCell.height - (sectionInset.top + sectionInset.bottom)) - (minimumInteritemSpacing * 2)) / 3
        
        return CGSize(width: width, height: height)
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = HorizontalPagingCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.sectionInset = sectionInset
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = false
        view.decelerationRate = .fast
        view.register(NewsLastestCollectionViewCell.self, forCellWithReuseIdentifier: NewsLastestCollectionViewCell.identifier)
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    var didSelectDirectLinking: ((String?) -> Void)?
    
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
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    // MARK: Configure
    func reloadWithData(_ twitters: [TwitterNews]) {
        self.lastests = twitters
        collectionView.reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension NewsLastestTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lastests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsLastestCollectionViewCell.identifier, for: indexPath) as! NewsLastestCollectionViewCell
        
        let randomIndex = Int(arc4random_uniform(UInt32(images.count)))
        let image = self.images[randomIndex]
        cell.configure(lastests[indexPath.row], image: image)
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension NewsLastestTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectDirectLinking?(lastests[indexPath.row].link)
    }
}
