//
//  AccountManagement.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import Foundation

class AccountManagement {
    
    static var isLoggedIn: Bool {
        return token != nil
    }
    
    static var token: String? {
        get {
            return UserDefaults.standard.string(forKey: Key.UserDefault.AuthorizationToken)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Key.UserDefault.AuthorizationToken)
        }
    }
    
    class func refresh() {
        token = nil
    }
}
