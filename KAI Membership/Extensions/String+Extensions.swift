//
//  String+Extensions.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 20/02/2021.
//

import UIKit

extension String: BaseModel { }

extension String {
    
    func setTextWithFormat(font: UIFont, textAlignment: NSTextAlignment = .left, letterSpacing: CGFloat = 0, lineHeight: CGFloat = 18, textColor: UIColor = .black, lineHeightMultiple: CGFloat? = nil) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: self)
        attributedText.addAttribute(.font, value: font, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        attributedText.addAttribute(.foregroundColor, value: textColor, range: NSRange(location: 0, length: attributedText.length))
        
        do {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.maximumLineHeight = lineHeight
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.alignment = textAlignment
            
            if let lineHeightMultiple = lineHeightMultiple {
                paragraphStyle.lineHeightMultiple = lineHeightMultiple
            }
            
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        }
        
        return attributedText
    }
}
