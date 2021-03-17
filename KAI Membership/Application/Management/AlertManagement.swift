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
    
    func showBulletin(with title: String, image: UIImage?, descriptionText: String?, fromController: UIViewController, primaryButtonTitle: String?, secondaryButtonTitle: String?, primaryHandler: ((BLTNActionItem) -> Void)?, secondaryHandler: ((BLTNActionItem) -> Void)?) {
        
        let bulletinItem = BLTNPageItem(title: title)
        bulletinItem.image = image
        bulletinItem.descriptionText = descriptionText
        bulletinItem.actionButtonTitle = primaryButtonTitle
        bulletinItem.actionHandler = primaryHandler
        bulletinItem.alternativeButtonTitle = secondaryButtonTitle
        bulletinItem.alternativeHandler = secondaryHandler
        
        bulletinItem.appearance.titleTextColor = UIColor.init(hex: "000000").withAlphaComponent(0.87)
        bulletinItem.appearance.titleFontSize = 28
        
        bulletinItem.appearance.descriptionTextColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.54)
        bulletinItem.appearance.descriptionFontSize = 14
        
        bulletinItem.appearance.actionButtonTitleColor = .white
        bulletinItem.appearance.actionButtonColor = UIColor.init(hex: "394656")
        bulletinItem.appearance.actionButtonFontSize = 16
        bulletinItem.appearance.actionButtonCornerRadius = 8
        
        bulletinItem.appearance.alternativeButtonTitleColor = UIColor.init(hex: "000000").withAlphaComponent(0.87)
        bulletinItem.appearance.alternativeButtonBorderColor = UIColor.init(hex: "C9CED6")
        bulletinItem.appearance.alternativeButtonBorderWidth = 1
        bulletinItem.appearance.alternativeButtonFontSize = 16
        bulletinItem.appearance.alternativeButtonCornerRadius = 8
        
        let bulletin = BLTNItemManager(rootItem: bulletinItem)
        bulletin.cardCornerRadius = 12
        bulletin.backgroundColor = .white
        bulletin.backgroundViewStyle = .dimmed
        bulletin.edgeSpacing = .custom(32)
        
        bulletin.showBulletin(above: fromController, animated: true, completion: nil)
    }
}
