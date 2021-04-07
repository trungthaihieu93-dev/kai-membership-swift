//
//  KaiStarterTableViewCell.swift
//  KAI Membership
//
//  Created by DAKiet on 31/03/2021.
//

import UIKit

protocol KaiStarterTableViewCellDelegate: class {
    func kaiStarterTableViewCellDidSelectViewAll(_ kaiStarterTableViewCell: KaiStarterTableViewCell)
    func kaiStarterTableViewCell(_ kaiStarterTableViewCell: KaiStarterTableViewCell, didSelectItemAt indexPath: IndexPath)
}

class KaiStarterTableViewCell: UITableViewCell {
    
    // MARK: Properties
    private let sectionInset: UIEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 20)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var viewAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(NSAttributedString(string: "View all", attributes: [
            NSAttributedString.Key.font: UIFont.workSansFont(ofSize: 14, weight: .medium),
            NSAttributedString.Key.foregroundColor: UIColor(hex: "023AFF")
        ]), for: .normal)
        button.contentEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 20)
        button.addTarget(self, action: #selector(onPressedViewAll), for: .touchUpInside)
        
        return button
    }()
    
    var contentTitle: String = "" {
        didSet {
            titleLabel.text = contentTitle
        }
    }
    
    private(set) lazy var collectionView: UICollectionView = {
        let layout = HorizontalPagingCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
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
    
    weak var delegate: KaiStarterTableViewCellDelegate?
    
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
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(viewAllButton)
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            viewAllButton.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            viewAllButton.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor),
            viewAllButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewAllButton.heightAnchor.constraint(equalToConstant: 40),

            titleLabel.centerYAnchor.constraint(equalTo: viewAllButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            collectionView.topAnchor.constraint(equalTo: viewAllButton.bottomAnchor, constant: 2),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    // MARK: Layout
    func reloadWithData() {
        collectionView.reloadData()
    }
    
    // MARK: Handle actions
    @objc private func onPressedViewAll() {
        delegate?.kaiStarterTableViewCellDidSelectViewAll(self)
    }
}

// MARK: UICollectionViewDataSource
extension KaiStarterTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KaiStarterCollectionViewCell.identifier, for: indexPath) as! KaiStarterCollectionViewCell
        cell.configure(imageLink: nil, title: "Sugar Baby \(indexPath.row)", description: "A web drama produced by Big Cat Entertainment and broadcast on 6 million-subscribers Youtube channel - Ghien Mi Go.", curentKai: 8700000, backers: 32, totalKai: 10000000)
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension KaiStarterTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width - (sectionInset.left + sectionInset.right)
        
        return CGSize(width: width, height: KaiStarterCollectionViewCell.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.kaiStarterTableViewCell(self, didSelectItemAt: indexPath)
    }
}
