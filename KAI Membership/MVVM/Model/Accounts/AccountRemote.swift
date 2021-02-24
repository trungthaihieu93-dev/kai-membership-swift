//
//  AccountRemote.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 24/02/2021.
//

import Foundation

class AccountRemote: Codable {
    
    var uuid: String?
    var token: String?
    var name: String?
    var phone: String?
    var gender: String?
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case token
        case name
        case gender
        case phone
    }
    
    func toDataLocal() -> AccountLocal {
        let data = AccountLocal(with: uuid, token: token, name: name, phone: phone, gender: gender)
        
        return data
    }
}
