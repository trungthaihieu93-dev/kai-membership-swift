//
//  UIImageView+Extensions.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 03/03/2021.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(from link: String?, placeholder: UIImage? = nil) {
        guard let link = link, let url = URL(string: link) else {
            self.image = placeholder
            return
        }
        
        self.kf.setImage(with: url, placeholder: placeholder)
    }
}
