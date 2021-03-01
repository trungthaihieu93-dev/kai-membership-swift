//
//  Constants.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 24/02/2021.
//

import UIKit

enum CurrencySeparator: String {
    case dots = "."
    case comma = ","
}

enum UnitCurrency: String {
    case kai = "KAI"
    case vnd = "VNĐ"
}

class Constants {
    
    static let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "undefined"
    static let environment = Constants.isDebug ? Environment.production : Environment.production
    
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
        static let screenSize = UIScreen.main.bounds
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
        case production = "https://membership-backend.kardiachain.io"
        case development = "https://reviewapi.riviu.co"
    }
}
