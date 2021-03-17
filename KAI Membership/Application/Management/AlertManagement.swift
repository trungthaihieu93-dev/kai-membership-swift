//
//  AlertManager.swift
//  KAI Membership
//
//  Created by KAISER on 17/03/2021.
//

import Foundation
import BLTNBoard

class AlertManagement {
    
    static let shared = AlertManagement()
    
    private lazy var bulletin: BLTNItemManager? = {
            let rootItem = BLTNItem()
            return BLTNItemManager(rootItem: rootItem)
        }()
    
    func showBulletin(with title: String, image: UIImage?, descriptionText: String?, fromController: UIViewController, primaryButtonTitle: String?, secondaryButtonTitle: String?, primaryHandler: ((BLTNActionItem) -> Void)?, secondaryHandler: ((BLTNActionItem) -> Void)?) {
        
        let bulletinItem = BLTNPageItem(title: title)
        
        bulletinItem.image = image
        bulletinItem.imageView?.contentMode = .scaleAspectFit
        
        bulletinItem.descriptionText = descriptionText
        bulletinItem.requiresCloseButton = false
        
        bulletinItem.actionButtonTitle = primaryButtonTitle
        bulletinItem.actionHandler = { [weak self] item in
            primaryHandler?(item)
            self?.bulletin?.dismissBulletin(animated: true)
            self?.bulletin = nil
        }
        
        bulletinItem.alternativeButtonTitle = secondaryButtonTitle
        bulletinItem.alternativeHandler = secondaryHandler
        
        bulletinItem.appearance.titleTextColor = UIColor.init(hex: "000000").withAlphaComponent(0.87)
        bulletinItem.appearance.titleFontSize = 28
        bulletinItem.appearance.titleFont = UIFont.workSansFont(ofSize: 28, weight: .semiBold)
        
        bulletinItem.appearance.descriptionTextColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.54)
        bulletinItem.appearance.descriptionFontSize = 14
        bulletinItem.appearance.descriptionFont = UIFont.workSansFont(ofSize: 14, weight: .medium)
        
        bulletinItem.appearance.actionButtonTitleColor = .white
        bulletinItem.appearance.actionButtonColor = UIColor.init(hex: "181E25")
        bulletinItem.appearance.actionButtonFontSize = 16
        bulletinItem.appearance.actionButtonCornerRadius = 8
        bulletinItem.appearance.buttonFont = UIFont.workSansFont(ofSize: 16, weight: .medium)
        
        bulletinItem.appearance.alternativeButtonTitleColor = UIColor.init(hex: "000000").withAlphaComponent(0.87)
        bulletinItem.appearance.alternativeButtonBorderColor = UIColor.init(hex: "C9CED6")
        bulletinItem.appearance.alternativeButtonBorderWidth = 1
        bulletinItem.appearance.alternativeButtonFontSize = 16
        bulletinItem.appearance.alternativeButtonCornerRadius = 8
        
        
        bulletin = BLTNItemManager(rootItem: bulletinItem)
        bulletin?.cardCornerRadius = 12
        bulletin?.backgroundColor = .white
        bulletin?.backgroundViewStyle = .blurredDark
        
        bulletin?.showBulletin(above: fromController, animated: true, completion: nil)
    }
}
