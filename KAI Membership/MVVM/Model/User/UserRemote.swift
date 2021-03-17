//
//  UserRemote.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 24/02/2021.
//

import Foundation

class UserRemote: BaseModel {
    
    var id: String?// = "guest"
    var username: String?
    var birthday: Double?
    var createdDate: String?
    var updatedDate: String?
    var phone: String?
    var avatarLink: String?
    var isActive: Bool = false
    var customerID: Int?
    var lastLogin: String?
    var platform: String?
    var isUpdated: Bool = false
    var email: String?
    var rateApp: Int?
//    var fcmToken: String?
    var passcode: String?
//    var refreshToken: String?
    var isCaptcha: Bool = false
    var isVerified: Bool = false
    var lastRegionLogin: String?
    var refarralAppflyerLink: String?
    var spinTurn: Int // > 0 hien dau cham
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case username
        case birthday = "birthday_time"
        case createdDate
        case updatedDate
        case phone
        case avatarLink = "avatar"
        case isActive
        case point
        case customerID
        case lastLogin = "last_login"
        case platform = "os"
        case isUpdated
        case email
        case rateApp = "rate_app"
//        case fcmToken = "fcm_token"
        case passcode
//        case refreshToken
        case isCaptcha = "is_captcha"
        case isVerified = "is_verified"
        case lastRegionLogin = "last_region_login"
        case refarralAppflyerLink = "refarral_appflyer_link"
        case spinTurn = "spinturn"
    }
    
    init(with id: String? = nil, username: String? = nil, birthday: Double? = nil, createdDate: String? = nil, updatedDate: String? = nil, phone: String? = nil, avatarLink: String? = nil, isActive: Bool = false, customerID: Int? = nil, lastLogin: String? = nil, platform: String? = nil, isUpdated: Bool = false, email: String? = nil, rateApp: Int? = nil, passcode: String? = nil, isCaptcha: Bool = false, isVerified: Bool = false, lastRegionLogin: String? = nil, refarralAppflyerLink: String? = nil, spinTurn: Int = 0) {
        self.id = id
        self.username = username
        self.birthday = birthday
        self.createdDate = createdDate
        self.updatedDate = updatedDate
        self.phone = phone
        self.avatarLink = avatarLink
        self.isActive = isActive
        self.customerID = customerID
        self.lastLogin = lastLogin
        self.platform = platform
        self.isUpdated = isUpdated
        self.email = email
        self.rateApp = rateApp
        self.passcode = passcode
        self.isCaptcha = isCaptcha
        self.isVerified = isVerified
        self.lastRegionLogin = lastRegionLogin
        self.refarralAppflyerLink = refarralAppflyerLink
        self.spinTurn = spinTurn
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        } else if let userID = try container.decodeIfPresent(String.self, forKey: .userID) {
            self.id = userID
        } else {
            self.id = nil
        }
        
        username = try container.decodeIfPresent(String.self, forKey: .username)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        birthday = try container.decodeIfPresent(Double.self, forKey: .birthday)
        createdDate = try container.decodeIfPresent(String.self, forKey: .createdDate)
        updatedDate = try container.decodeIfPresent(String.self, forKey: .updatedDate)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        avatarLink = try container.decodeIfPresent(String.self, forKey: .avatarLink)
        isActive = try container.decodeIfPresent(Bool.self, forKey: .isActive) ?? false
        customerID = try container.decodeIfPresent(Int.self, forKey: .customerID)
        lastLogin = try container.decodeIfPresent(String.self, forKey: .lastLogin)
        platform = try container.decodeIfPresent(String.self, forKey: .platform)
        isUpdated = try container.decodeIfPresent(Bool.self, forKey: .isUpdated) ?? false
        rateApp = try container.decodeIfPresent(Int.self, forKey: .rateApp)
//        fcmToken = try container.decodeIfPresent(String.self, forKey: .fcmToken)
        passcode = try container.decodeIfPresent(String.self, forKey: .passcode)
//        refreshToken = try container.decodeIfPresent(String.self, forKey: .refreshToken)
        isCaptcha = try container.decodeIfPresent(Bool.self, forKey: .isCaptcha) ?? false
        isVerified = try container.decodeIfPresent(Bool.self, forKey: .isVerified) ?? false
        lastRegionLogin = try container.decodeIfPresent(String.self, forKey: .lastRegionLogin)
        refarralAppflyerLink = try container.decodeIfPresent(String.self, forKey: .refarralAppflyerLink)
        spinTurn = try container.decodeIfPresent(Int.self, forKey: .spinTurn) ?? 0
    }
    
    func toDataLocal() -> UserLocal {
        let data = UserLocal(with: id, email: email, avatarLink: avatarLink)
        
        return data
    }
    
    func encode(to encoder: Encoder) throws { }
}
