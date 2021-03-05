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
    
    func toDataLocal() -> UserLocal {
        let data = UserLocal(with: id, email: email, avatarLink: avatarLink)
        
        return data
    }
}
