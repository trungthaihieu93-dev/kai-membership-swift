//
//  Double+Extensions.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 27/02/2021.
//

import UIKit

extension Double {
    
    func formatTimeIntervalToString(_ dateFormat: String, addTime time: TimeInterval? = nil, timeZone: TimeZone? = TimeZone(abbreviation: "GMT+7:00")) -> String {
        var day = Date(timeIntervalSince1970: self)
        
        if let time = time { day.addTimeInterval(time) }
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.string(from: day)
    }
    
    func formatCurrencyToAttributedString(unit: UnitCurrency = .kai, groupingSeparator: CurrencySeparator = .comma, decimalSeparator: CurrencySeparator = .dots, font: UIFont, unitFont: UIFont? = nil, textColor: UIColor) -> NSAttributedString {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = groupingSeparator.rawValue
        formatter.decimalSeparator = decimalSeparator.rawValue
        formatter.numberStyle = .decimal
        
        let numberStr: String = formatter.string(for: self) ?? "0"
        let groupString: String = "\(numberStr) \(unit.rawValue)"
        let mutableAttributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: groupString, attributes: [
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.font: font
        ]))
        
        if let unitFont = unitFont {
            let lengthUnit: Int = unit.rawValue.count
            mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: unitFont, range: NSRange(location: groupString.count - lengthUnit, length: lengthUnit))
        }
        
        return mutableAttributedString
    }
}
