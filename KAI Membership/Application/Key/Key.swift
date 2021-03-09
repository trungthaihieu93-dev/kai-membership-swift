//
//  Key.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import Foundation

class Key {
    
    enum UserDefault: String {
        case darkMode = "KAI.UserDefault.DarkMode"
        case haveUsedTheApplicationOnce = "KAI.UserDefault.HaveUsedTheApplicationOnce"
    }
    
    enum KeyChain: String {
        case authorizationToken = "KAI.KeyChain.AuthorizationToken"
        case userID = "KAI.KeyChain.UserID"
        case kaiInfo = "KAI.KeyChain.KaiInfomation"
    }
}
