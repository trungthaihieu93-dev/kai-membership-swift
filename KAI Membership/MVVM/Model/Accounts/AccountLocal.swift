//
//  AccountLocal.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 24/02/2021.
//

import RealmSwift

class AccountLocal: RealmSwift.Object {
    
    @objc dynamic var uuid: String?
    @objc dynamic var token: String?
    @objc dynamic var name: String?
    @objc dynamic var phone: String?
    @objc dynamic var gender: String?
    
    override public static func primaryKey() -> String? {
        return "uuid"
    }
    
    required override init() { }
    
    init(with uuid: String? = nil, token: String? = nil, name: String? = nil, phone: String? = nil, gender: String? = nil) {
        self.uuid = uuid
        self.token = token
        self.name = name
        self.phone = phone
        self.gender = gender
    }
}
