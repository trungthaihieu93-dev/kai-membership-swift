//
//  TopupTableViewCell.swift
//  KAI Membership
//
//  Created by DAKiet on 11/03/2021.
//

import UIKit

protocol TopupTableViewCellDelegate: class {
    func topupTableViewCellPhoneValueChange(_ topupTableViewCell: TopupTableViewCell, textField: UITextField)
}

class TopupTableViewCell: UITableViewCell {
    
    // MARK: Properties
    enum ProviderType: Int, CaseIterable {
        case viettel
        case mobifone
        case vinaphone
    }
    
    private let sectionInsets: UIEdgeInsets = .init(top: 2, left: 16, bottom: 2, right: 16)
    private let minimumLineSpacing: CGFloat = 12
    private let itemHeight: CGFloat = 60
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.init(hex: "F1F2F4").cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    private let contactLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 10, weight: .medium)
        label.textColor = .init(hex: "364766")
        label.text = "PHONE NO."
        
        return label
    }()
    
    private lazy var contactTextField: KAITextField = {
        let view = KAITextField(with: .default, keyboardType: .phonePad, placeholder: "e.g 01669919308")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    private let providerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 10, weight: .medium)
        label.textColor = .init(hex: "364766")
        label.text = "SERVICE PROVIDER"
        
        return label
    }()
    
    private(set) lazy var providerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = minimumLineSpacing
        layout.sectionInset = sectionInsets
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        view.register(ProviderCollectionViewCell.self, forCellWithReuseIdentifier: ProviderCollectionViewCell.identifier)
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    private let comboboxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 10, weight: .medium)
        label.textColor = .init(hex: "364766")
        label.text = "TOP UP AMOUNT"
        
        return label
    }()
    
    private let combobox: KAICombobox = {
        let view = KAICombobox(with: [
            KAICombobox.ComboboxData(title: "20.000 VND", subTitle: "(66.6666 KAI)"),
            KAICombobox.ComboboxData(title: "50.000 VND", subTitle: "(166.6666 KAI)"),
            KAICombobox.ComboboxData(title: "100.000 VND", subTitle: "(266.66666 KAI)"),
            KAICombobox.ComboboxData(title: "200.000 VND", subTitle: "(366.66666 KAI)")
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private(set) var providerSelectedIndex: Int = 0 {
        didSet {
            guard providerSelectedIndex != oldValue else { return }
            
            if let oldCell = providerCollectionView.cellForItem(at: IndexPath(row: oldValue, section: 0)) as? ProviderCollectionViewCell {
                oldCell.isProviderSelected = false
            }
            
            if let newCell = providerCollectionView.cellForItem(at: IndexPath(row: providerSelectedIndex, section: 0)) as? ProviderCollectionViewCell {
                newCell.isProviderSelected = true
            }
        }
    }
    
    var comboboxSelectedIndex: Int {
        return combobox.selectedIndex
    }
    
    weak var delegate: TopupTableViewCellDelegate?
    
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
        
        contentView.addSubview(containerView)
            
        containerView.addSubview(contactLabel)
        containerView.addSubview(contactTextField)
        containerView.addSubview(providerLabel)
        containerView.addSubview(providerCollectionView)
        containerView.addSubview(comboboxLabel)
        containerView.addSubview(combobox)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            contactLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            contactLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            contactLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            contactTextField.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 4),
            contactTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            contactTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            providerLabel.topAnchor.constraint(equalTo: contactTextField.bottomAnchor, constant: 12),
            providerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            providerLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            providerCollectionView.topAnchor.constraint(equalTo: providerLabel.bottomAnchor, constant: 4),
            providerCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            providerCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            providerCollectionView.heightAnchor.constraint(equalToConstant: itemHeight + sectionInsets.top + sectionInsets.bottom),
            
            comboboxLabel.topAnchor.constraint(equalTo: providerCollectionView.bottomAnchor, constant: 10),
            comboboxLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            comboboxLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            combobox.topAnchor.constraint(equalTo: comboboxLabel.bottomAnchor, constant: 4),
            combobox.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            combobox.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            combobox.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
        ])
    }
    
    // MARK: Layout
    func configure() {
        
    }
}

// MARK: KAITextFieldDelegate
extension TopupTableViewCell: KAITextFieldDelegate {

    func kAITextFieldDidChange(_ textField: UITextField, for view: UIView) {
        delegate?.topupTableViewCellPhoneValueChange(self, textField: textField)
    }
    
    func kAITextFieldShouldReturn(_ textField: UITextField, for view: UIView) -> Bool {
        return false
    }
    
    func kAITextFieldShouldClear(_ textField: UITextField, for view: UIView) -> Bool {
        return true
    }
}

// MARK: UICollectionViewDataSource
extension TopupTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProviderType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProviderCollectionViewCell.identifier, for: indexPath) as! ProviderCollectionViewCell
        
        if let providerType = ProviderType(rawValue: indexPath.row) {
            switch providerType {
            case .viettel:
                cell.configure(UIImage(named: "logo_viettel"))
            case .mobifone:
                cell.configure(UIImage(named: "logo_mobifone"))
            case .vinaphone:
                cell.configure(UIImage(named: "logo_vinaphone"))
            }
        }
        
        cell.isProviderSelected = providerSelectedIndex == indexPath.row
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension TopupTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (Constants.Device.screenBounds.width - (sectionInsets.left + sectionInsets.right + minimumLineSpacing * 2 + 40)) / 3
        
        return CGSize(width: width, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        providerSelectedIndex = indexPath.row
    }
}
