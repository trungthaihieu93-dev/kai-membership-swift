//
//  String+Extensions.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 20/02/2021.
//

import UIKit

extension String: BaseModel { }

extension String {
    
    private func isAllDigits() -> Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "0123456789").inverted
        let inputString = self.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        
        return self == filtered
    }
    
    var isPhoneNumber: Bool {
        if self.isAllDigits() == true {
            let phoneRegex = "^(0[0-9]{9}|[1-9]{1}[0-9]{8})$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
    
            return predicate.evaluate(with: self)
        } else {
            return false
        }
    }
}

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
