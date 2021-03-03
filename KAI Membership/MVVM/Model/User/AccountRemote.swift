//
//  UserRemote.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 24/02/2021.
//

import Foundation

class UserRemote: BaseModel {
    
    var id: String?// = "guest"
    var email: String?
    var avatarLink: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case email
        case avatarLink = "avatar"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        avatarLink = try container.decodeIfPresent(String.self, forKey: .avatarLink)
    }
}

class AccountRemote: BaseModel {
    
    var accessToken: String?
    var refreshToken: String?
    var expiresIn: Double?
    var isFirst: Bool
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case isFirst = "is_first"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try container.decodeIfPresent(String.self, forKey: .accessToken)
        refreshToken = try container.decodeIfPresent(String.self, forKey: .refreshToken)
        expiresIn = try container.decodeIfPresent(Double.self, forKey: .expiresIn)
        isFirst = try container.decodeIfPresent(Bool.self, forKey: .isFirst) ?? false
    }
    
    func toDataLocal() -> AccountLocal {
        let data = AccountLocal(with: "uuid", token: "token", name: "name", phone: "phone", gender: "gender")
        
        return data
    }
}
