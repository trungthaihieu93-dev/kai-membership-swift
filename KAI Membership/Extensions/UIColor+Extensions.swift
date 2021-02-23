//
//  UIColor+Extensions.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import UIKit

extension UIColor {
    @nonobjc convenience init(hex: String) {
        let characterSet = (CharacterSet.whitespacesAndNewlines as NSCharacterSet).mutableCopy() as! NSMutableCharacterSet
        characterSet.formUnion(with: CharacterSet(charactersIn: "#"))
        let cString = hex.trimmingCharacters(in: characterSet as CharacterSet).uppercased()
        if (cString.count != 6) {
            self.init(white: 1.0, alpha: 1.0)
        } else {
            var rgbValue: UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                      alpha: CGFloat(1.0))
        }
    }
}
