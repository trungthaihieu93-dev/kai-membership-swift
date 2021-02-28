//
//  UITableViewCell+Extensions.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 28/02/2021.
//

import UIKit

extension UITableViewCell {
    
    class var identifier: String {
        return String(describing: type(of: self))
    }
    
//    class var identifier: String {
//        return NSStringFromClass(self).components(separatedBy: ".").last!
//    }
}
