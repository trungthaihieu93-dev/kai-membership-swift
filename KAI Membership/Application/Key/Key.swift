//
//  Key.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import Foundation

class Key {
    
    struct UserDefault {
        static let DarkMode = "KAI.UserDefault.DarkMode"
        static let HaveUsedTheApplicationOnce = "KAI.UserDefault.HaveUsedTheApplicationOnce"
    }
    
    enum KeyChain: String {
        case authorizationToken = "KAI.KeyChain.AuthorizationToken"
        case userID = "KAI.KeyChain.UserID"
    }
}
