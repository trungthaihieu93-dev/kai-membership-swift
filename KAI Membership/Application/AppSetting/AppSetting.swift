//
//  AppSetting.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 26/02/2021.
//

import Foundation

class AppSetting {
    
    /* Dark mode */
    static var isDarkMode: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: Key.UserDefault.DarkMode)
        }
        get {
            return UserDefaults.standard.bool(forKey: Key.UserDefault.DarkMode)
        }
    }
}
