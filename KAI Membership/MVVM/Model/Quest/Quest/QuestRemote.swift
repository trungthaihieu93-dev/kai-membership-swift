//
//  QuestRemote.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 05/03/2021.
//

import Foundation

enum QuestType: String {
    case daily = "DAILY"
    case monthly = "MONTH"
}

enum QuestKey: String {
    case highestScores = "HIGHEST_SCORES"// Web
    case thiryMinutes = "THIRTY_MINUTES" // play game 30' // Web
    case inviteFriend = "INVITE_FRIEND" // ok
    case sendKai = "SEND_KAI" //đẩy màn hình send Kai (chuyễn thành công thì mới gọi API này update nhiệm vụ send Kai)
    case encourageKaiTeam = "RATE_APP" // gọi hàm request racing => hoàn thành
    case signIn = "SIGN_IN"
    case verifyEmail = "VERIFY_MY_EMAIL"
    case followTwitter = "FOLLOW_US_ON_TWITTER"
    case likeFBPage = "LIKE_OUR_FACEBOOK_PAGE"
    case joinTelegramGroup = "JOIN_OUR_TELEGRAM_GROUP"
}

class QuestRemote: BaseModel {
    
    var id: String?
    var createdDate: String?
    var updatedDate: String?
    var name: String?
    var screenName: String?
    var key: QuestKey = .signIn
    var type: QuestType = .daily
    var progress: Int?
    var userQuest: UserQuestRemote?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case createdDate = "created_date"
        case updatedDate = "updated_date"
        case name = "mission"
        case screenName = "screen_name"
        case key
        case type
        case progress = "process"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id)
        createdDate = try container.decodeIfPresent(String.self, forKey: .createdDate)
        updatedDate = try container.decodeIfPresent(String.self, forKey: .updatedDate)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        screenName = try container.decodeIfPresent(String.self, forKey: .screenName)
        
        if let key = try container.decodeIfPresent(String.self, forKey: .key) {
            self.key = QuestKey(rawValue: key) ?? .signIn
        } else {
            self.key = .signIn
        }
        
        if let type = try container.decodeIfPresent(String.self, forKey: .type) {
            self.type = QuestType(rawValue: type) ?? .daily
        } else {
            self.type = .daily
        }
        
        progress = try container.decodeIfPresent(Int.self, forKey: .progress)
    }
    
    func encode(to encoder: Encoder) throws { }
}

