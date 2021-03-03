//
//  NewRemote.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 04/03/2021.
//

import Foundation

class NewRemote: BaseModel {
    
    var id: String?
    var name: String?
    var imageLink: String?
    var time: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageLink = "image_link"
        case time
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        imageLink = try container.decodeIfPresent(String.self, forKey: .imageLink)
        time = try container.decodeIfPresent(String.self, forKey: .time)
    }
    
    func encode(to encoder: Encoder) throws { }
}
