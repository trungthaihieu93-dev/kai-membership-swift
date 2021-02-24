//
//  Constants.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 24/02/2021.
//

import UIKit

class Constants {
    
    static let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "undefined"
    static let environment = Constants.isDebug ? Environment.development : Environment.production
    
    static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    struct Device {
        static let id: String = UIDevice.current.identifierForVendor?.uuidString ?? "undefined"
        static let name: String = UIDevice.current.name.folding(options: .diacriticInsensitive, locale: .current)
        static let model: String = UIDevice.current.model
        static let version: String = UIDevice.current.systemVersion
    }
}

enum Environment {
    case production
    case development
    
    var domain: String {
        switch self {
        case .production:
            return API.Domain.production.rawValue
        case .development:
            return API.Domain.development.rawValue
        }
    }
}

struct API {
    
    enum Domain: String {
        case production = "https://reviewapi.riviu.co"
        case development = "https://review-api-development.riviu.co"
    }
}
