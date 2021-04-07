//
//  KaiProjectRemote.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 05/04/2021.
//

import Foundation

class KaiProjectRemote: BaseModel {
    
    var id: String?
    var name: String?
    var description: String?
    var current: Double = 0
    var target: Double?
    var backers: Int?
    var imageLink: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case current
        case target
        case backers
        case imageLink
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        current = try container.decodeIfPresent(Double.self, forKey: .current) ?? 0
        target = try container.decodeIfPresent(Double.self, forKey: .target)
        backers = try container.decodeIfPresent(Int.self, forKey: .backers)
        imageLink = try container.decodeIfPresent(String.self, forKey: .imageLink)
    }
    
    init(with id: String? = nil, name: String? = nil, description: String? = nil, current: Double = 0, target: Double? = nil, backers: Int? = nil, imageLink: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.current = current
        self.target = target
        self.backers = backers
        self.imageLink = imageLink
    }
}
