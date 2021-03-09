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
    var email: String?
    var gender: String?
    var birthday: String?
    var createdDate: String?
    var updatedDate: String?
    var phone: String?
    var avatarLink: String?
    var active: Bool = false
    var point: Double?
//    var missioncompleted
    var spinedCount: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case email
        case username
        case gender = "sex"
        case birthday
        case createdDate
        case updatedDate
        case phone
        case avatarLink = "avatar"
        case active
        case point
//        case missionCompleted = "missioncompleted"
        case spinedCount = "spinedcount"
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
        gender = try container.decodeIfPresent(String.self, forKey: .gender)
        birthday = try container.decodeIfPresent(String.self, forKey: .birthday)
        createdDate = try container.decodeIfPresent(String.self, forKey: .createdDate)
        updatedDate = try container.decodeIfPresent(String.self, forKey: .updatedDate)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        avatarLink = try container.decodeIfPresent(String.self, forKey: .avatarLink)
        active = try container.decodeIfPresent(Bool.self, forKey: .active) ?? false
        point = try container.decodeIfPresent(Double.self, forKey: .point)
        spinedCount = try container.decodeIfPresent(Int.self, forKey: .spinedCount) ?? 0
    }
    
    func toDataLocal() -> UserLocal {
        let data = UserLocal(with: id, email: email, avatarLink: avatarLink)
        
        return data
    }
    
    func encode(to encoder: Encoder) throws { }
}
