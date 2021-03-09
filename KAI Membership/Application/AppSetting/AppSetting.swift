//
//  AppSetting.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 26/02/2021.
//

import Foundation

class AppSetting {
    
    static var isDarkMode: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: Key.UserDefault.darkMode.rawValue)
        }
        get {
            return UserDefaults.standard.bool(forKey: Key.UserDefault.darkMode.rawValue)
        }
    }
    
    static var haveUsedTheApplicationOnce: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: Key.UserDefault.haveUsedTheApplicationOnce.rawValue)
        }
        get {
            return UserDefaults.standard.bool(forKey: Key.UserDefault.haveUsedTheApplicationOnce.rawValue)
        }
    }
}
