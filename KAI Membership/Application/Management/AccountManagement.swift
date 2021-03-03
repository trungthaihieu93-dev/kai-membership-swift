//
//  AccountManagement.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import Foundation

class AccountManagement {
    
    static var isLoggedIn: Bool {
        return token != nil && userId != nil
    }
    
    static var token: String? {
        get {
            return KeyChain.load(forKey: .authorizationToken)?.to(type: String.self)
        }
        set {
            _ = KeyChain.save(forKey: .authorizationToken, data: Data(from: newValue))
        }
    }
    
    static var userId: String? {
        get {
            return KeyChain.load(forKey: .userID)?.to(type: String.self)
        }
        set {
            _ = KeyChain.save(forKey: .userID, data: Data(from: newValue))
        }
    }
    
    class func refresh() {
        token = nil
        userId = nil
    }
}
