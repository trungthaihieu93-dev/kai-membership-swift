//
//  KAICombobox.swift
//  KAI Membership
//
//  Created by DAKiet on 12/03/2021.
//

import UIKit

class KAICombobox: UIView {
    
    // MARK: Properties
    private let itemHeight: CGFloat = 40
    private let maxItemShow: CGFloat = 5
    private let transparentView = UIView()
    
    private let dropdownImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ic_dropdown"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.black.withAlphaComponent(0.87)
        label.font = .workSansFont(ofSize: 14, weight: .medium)
        
        return label
    }()
    
    private lazy var selectedButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .init(hex: "FAFBFB")
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.init(hex: "E1E4E8").cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(onPressedDropdown), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: 16, left: 0, bottom: 16, right: 0)
        tableView.backgroundColor = .white
        tableView.register(ComboboxTableViewCell.self, forCellReuseIdentifier: ComboboxTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private let dataSources: [String]
    
    private(set) var selectedIndex: Int = 0 {
        didSet {
            guard selectedIndex != oldValue else { return }
            
            if let oldCell = tableView.cellForRow(at: IndexPath(row: oldValue, section: 0)) as? ComboboxTableViewCell {
                oldCell.isDropdownSelected = false
            }
            
            if let newCell = tableView.cellForRow(at: IndexPath(row: selectedIndex, section: 0)) as? ComboboxTableViewCell {
                newCell.isDropdownSelected = true
            }
            
            valueLabel.text = dataSources[selectedIndex]
            removeTransparentView()
        }
    }
    
    // MARK: Life cycle's
    init(with dataSources: [String], frame: CGRect = .zero) {
        self.dataSources = dataSources
        
        super.init(frame: frame)
        
        valueLabel.text = dataSources.first
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    func setupView() {
        addSubview(selectedButton)
        addSubview(valueLabel)
        addSubview(dropdownImageView)
        
        NSLayoutConstraint.activate([
            selectedButton.topAnchor.constraint(equalTo: topAnchor),
            selectedButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectedButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            selectedButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectedButton.heightAnchor.constraint(equalToConstant: 44),
            
            valueLabel.centerYAnchor.constraint(equalTo: selectedButton.centerYAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: selectedButton.leadingAnchor, constant: 16),
            
            dropdownImageView.centerYAnchor.constraint(equalTo: selectedButton.centerYAnchor),
            dropdownImageView.leadingAnchor.constraint(greaterThanOrEqualTo: valueLabel.trailingAnchor, constant: 8),
            dropdownImageView.trailingAnchor.constraint(equalTo: selectedButton.trailingAnchor, constant: -14),
            dropdownImageView.widthAnchor.constraint(equalToConstant: 16),
            dropdownImageView.heightAnchor.constraint(equalToConstant: 16),
        ])
    }
    
    private func addTransparentView() {
        let frames: CGRect = selectedButton.convert(selectedButton.frame, to: nil)
        let window = Navigator.window
        transparentView.frame = window?.frame ?? CGRect(origin: .zero, size: Constants.Device.screenBounds.size)
        window?.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        window?.addSubview(tableView)
        tableView.layer.cornerRadius = 8
        tableView.createShadow(radius: 8)
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        let margin: CGFloat = tableView.contentInset.left + tableView.contentInset.right
        let height: CGFloat = CGFloat(dataSources.count) * itemHeight + margin
        let maxHeight: CGFloat = (maxItemShow * itemHeight) + margin
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: height > maxHeight ? maxHeight : height)
            self.dropdownImageView.transform = CGAffineTransform(rotationAngle: .pi)
        }, completion: nil)
    }
    
    // MARK: Handle actions
    @objc func removeTransparentView() {
        let frames: CGRect = selectedButton.convert(selectedButton.frame, to: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
            self.dropdownImageView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    @objc private func onPressedDropdown() {
        addTransparentView()
        Navigator.window?.endEditing(true)
    }
}

// MARK: UITableViewDataSource
extension KAICombobox: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ComboboxTableViewCell.identifier, for: indexPath) as! ComboboxTableViewCell
        cell.configure(dataSources[indexPath.row])
        cell.isDropdownSelected = selectedIndex == indexPath.row
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension KAICombobox: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
    }
}

class ComboboxTableViewCell: UITableViewCell {
    
    // MARK: Properties
    private let titleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.font = UIFont.workSansFont(ofSize: 14, weight: .medium)
        button.isEnabled = false
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = .init(top: 5, left: 16, bottom: 5, right: 16)
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    var isDropdownSelected: Bool = false {
        didSet {
            if isDropdownSelected {
                titleButton.backgroundColor = .init(hex: "F7F8F9")
                titleButton.setTitleColor(UIColor.black.withAlphaComponent(0.87), for: .normal)
            } else {
                titleButton.backgroundColor = nil
                titleButton.setTitleColor(UIColor.black.withAlphaComponent(0.54), for: .normal)
            }
        }
    }
    
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
        
        contentView.addSubview(titleButton)
        
        NSLayoutConstraint.activate([
            titleButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    // MARK: Methods
    func configure(_ text: String) {
        titleButton.setTitle(text, for: .normal)
    }
}
