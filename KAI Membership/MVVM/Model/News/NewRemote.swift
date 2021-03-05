//
//  NewRemote.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 04/03/2021.
//

import Foundation

class NewRemote: BaseModel {
    
    var id: String?
    var title: String?
    var imageLink: String?
    var publicDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imageLink = "image_link"
        case publicDate = "public_date"
    }
    
    init(with id: String? = nil, title: String? = nil, imageLink: String? = nil, publicDate: String? = nil) {
        self.id = id
        self.title = title
        self.imageLink = imageLink
        self.publicDate = publicDate
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        imageLink = try container.decodeIfPresent(String.self, forKey: .imageLink)
        publicDate = try container.decodeIfPresent(String.self, forKey: .publicDate)
    }
    
    func encode(to encoder: Encoder) throws { }
}
