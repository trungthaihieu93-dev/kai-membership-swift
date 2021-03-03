//
//  NewsSuggestionTableViewCell.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 04/03/2021.
//

import UIKit

class NewsSuggestionTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
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
        
        contentView.backgroundColor = .yellow
    }
}
