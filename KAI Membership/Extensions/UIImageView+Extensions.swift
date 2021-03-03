//
//  UIImageView+Extensions.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 03/03/2021.
//

import UIKit

extension UIImageView {
    
    func setImage(from link: String?, placeholder: UIImage? = nil) {
        self.image = placeholder
        
        guard let link = link, let imageURL = URL(string: link) else { return }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
