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
        case serviceProviders = "KAI.UserDefault.ServiceProviders"
        case linkBuyApp = "KAI.UserDefault.LinkBuyApp"
        case configure = "KAI.UserDefault.Configure"
        case haveFreeSpin = "KAI.UserDefault.HaveFreeSpin"
        case isRequestOpenSpin = "KAI.UserDefault.IsRequestOpenSpin"
        case referrerID = "KAI.UserDefault.ReferrerID"
    }
    
    enum KeyChain: String {
        case authorizationToken = "KAI.KeyChain.AuthorizationToken"
        case refreshToken = "KAI.KeyChain.refreshToken"
        case userID = "KAI.KeyChain.UserID"
        case email = "KAI.KeyChain.Email"
        case AccountInfo = "KAI.KeyChain.AccountInfomation"
    }
}
