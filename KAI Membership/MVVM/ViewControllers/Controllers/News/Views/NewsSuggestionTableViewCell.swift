//
//  NewsSuggestionTableViewCell.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 04/03/2021.
//

import UIKit

class NewsSuggestionTableViewCell: UITableViewCell {
    
    // MARK: Properties
    static let itemSize: CGSize = CGSize(width: 275, height: 360)
    
    private var suggestions = [MediumNews]()
    
    private let images = [
        UIImage(named: "news_1")?.resizeImage(newWidth: NewsSuggestionTableViewCell.itemSize.width * 4),
        UIImage(named: "news_2")?.resizeImage(newWidth: NewsSuggestionTableViewCell.itemSize.width * 4),
        UIImage(named: "news_3")?.resizeImage(newWidth: NewsSuggestionTableViewCell.itemSize.width * 4),
        UIImage(named: "news_4")?.resizeImage(newWidth: NewsSuggestionTableViewCell.itemSize.width * 4),
        UIImage(named: "news_5")?.resizeImage(newWidth: NewsSuggestionTableViewCell.itemSize.width * 4),
        UIImage(named: "news_6")?.resizeImage(newWidth: NewsSuggestionTableViewCell.itemSize.width * 4),
        UIImage(named: "news_7")?.resizeImage(newWidth: NewsSuggestionTableViewCell.itemSize.width * 4)
    ]
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.sectionInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.register(NewsSuggestionCollectionViewCell.self, forCellWithReuseIdentifier: NewsSuggestionCollectionViewCell.identifier)
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
    func reloadWithData(_ mediums: [MediumNews]) {
        self.suggestions = mediums
        collectionView.reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension NewsSuggestionTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsSuggestionCollectionViewCell.identifier, for: indexPath) as! NewsSuggestionCollectionViewCell
        
        let randomIndex = Int(arc4random_uniform(UInt32(images.count)))
        let image = self.images[randomIndex]
        cell.configure(suggestions[indexPath.row], image: image)
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension NewsSuggestionTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return NewsSuggestionTableViewCell.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectDirectLinking?(suggestions[indexPath.row].link)
    }
}
