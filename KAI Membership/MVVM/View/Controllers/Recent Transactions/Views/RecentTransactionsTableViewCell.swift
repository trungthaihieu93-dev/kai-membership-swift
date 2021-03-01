//
//  RecentTransactionsTableViewCell.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 28/02/2021.
//

import UIKit

class RecentTransactionsTableViewCell: UITableViewCell {
    
    // MARK: Properties
    private let transactionsImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.black.withAlphaComponent(0.87)
        
        return label
    }()
    
    private let transactionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 10, weight: .medium)
        label.textColor = UIColor.black.withAlphaComponent(0.26)
        
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.black.withAlphaComponent(0.87)
        
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .workSansFont(ofSize: 10, weight: .medium)
        label.textColor = UIColor.black.withAlphaComponent(0.26)
        
        return label
    }()
    
    // MARK: Lìe cycle's
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
        
        contentView.addSubview(transactionsImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(transactionsLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
//            transactionsImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 8),
            transactionsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            transactionsImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            transactionsImageView.widthAnchor.constraint(equalToConstant: 16),
            transactionsImageView.heightAnchor.constraint(equalToConstant: 16),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: transactionsImageView.trailingAnchor, constant: 14),
            
            valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 14),
            valueLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            transactionsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            transactionsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            transactionsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            timeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: transactionsLabel.trailingAnchor, constant: 6),
            timeLabel.centerYAnchor.constraint(equalTo: transactionsLabel.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: valueLabel.trailingAnchor)
        ])
        
        titleLabel.text = "Buy"
        valueLabel.text = "+ 17.000"
        transactionsLabel.text = "From: L1A4Ny...Mhoq"
        timeLabel.text = "05:21 PM"
    }
    
    // MARK: Configure
    func configure() {
        
    }
}
