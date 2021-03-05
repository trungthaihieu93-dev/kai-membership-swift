//
//  WalletRemote.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 05/03/2021.
//

import Foundation

class WalletRemote: BaseModel {
    
    var balance: Double?
    var address: String?
    
    enum CodingKeys: String, CodingKey {
        case balance
        case address = "wallet_address"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        balance = try container.decodeIfPresent(Double.self, forKey: .balance)
        address = try container.decodeIfPresent(String.self, forKey: .address)
    }
}
