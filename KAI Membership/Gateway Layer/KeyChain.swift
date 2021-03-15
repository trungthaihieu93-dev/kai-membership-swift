//
//  KeyChain.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 04/03/2021.
//

import UIKit
import Security

class KeyChain {

    class func delete(forKey key: Key.KeyChain) {
        let query = [
            kSecClass       : kSecClassGenericPassword,
            kSecAttrAccount : key.rawValue,
        ] as CFDictionary

        SecItemDelete(query)
    }
    
    class func save(forKey key: Key.KeyChain, data: Data) {
        let query = [
            kSecClass       : kSecClassGenericPassword,
//            kSecAttrServer  : "kai.com",
            kSecAttrAccount : key.rawValue,
            kSecValueData   : data,
        ] as CFDictionary

        SecItemDelete(query)

        let status = SecItemAdd(query, nil)
        print("Operation finished with status: \(status)")
    }

    class func load(forKey key: Key.KeyChain) -> Data? {
        let query = [
            kSecClass       : kSecClassGenericPassword,
//            kSecAttrServer  : "kai.com",
            kSecAttrAccount : key.rawValue,
            kSecReturnData  : true,
            kSecMatchLimit  : kSecMatchLimitOne
        ] as CFDictionary

        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as? Data
        } else {
            return nil
        }
    }

    class func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)
        let swiftString: String = cfStr as String
        
        return swiftString
    }
}
