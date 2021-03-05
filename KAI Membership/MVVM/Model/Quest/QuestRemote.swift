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
    case unowned
}

class QuestRemote: BaseModel {
    
    var id: String?
    var createdDate: String?
    var updatedDate: String?
    var name: String?
    var screenName: String?
    var key: String?
    var type: QuestType = .unowned
    var process: Int = 0
    var status: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case createdDate = "created_date"
        case updatedDate = "updated_date"
        case name = "mission"
        case screenName = "screen_name"
        case key
        case type
        case process
        case status
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id)
        createdDate = try container.decodeIfPresent(String.self, forKey: .createdDate)
        updatedDate = try container.decodeIfPresent(String.self, forKey: .updatedDate)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        screenName = try container.decodeIfPresent(String.self, forKey: .screenName)
        key = try container.decodeIfPresent(String.self, forKey: .key)
        
        if let type = try container.decodeIfPresent(String.self, forKey: .type) {
            self.type = QuestType(rawValue: type) ?? .unowned
        } else {
            self.type = .unowned
        }
        
        process = try container.decodeIfPresent(Int.self, forKey: .process) ?? 0
        status = try container.decodeIfPresent(Bool.self, forKey: .status) ?? false
    }
    
    func encode(to encoder: Encoder) throws { }
}
