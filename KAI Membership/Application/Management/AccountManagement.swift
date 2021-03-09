//
//  AccountManagement.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import Foundation

class AccountManagement {
    
    static var isLoggedIn: Bool {
        return AccountManagement.token != nil //&& AccountManagement.userId != nil
    }
    
    static var token: String? {
        get {
            guard let data = KeyChain.load(forKey: .authorizationToken) else { return nil }

            return String(data: data, encoding: .utf8)
        }
        set {
            guard let data = newValue?.data(using: .utf8) else { return }

            KeyChain.save(forKey: .authorizationToken, data: data)
        }
    }
    
//    static var token: String? {
//        get {
//            return KeyChain.load(forKey: .authorizationToken)?.to(type: String.self)
//        }
//        set {
//            KeyChain.save(forKey: .authorizationToken, data: Data(from: newValue))
//        }
//    }
    
    static var userId: String? {
        get {
            guard let data = KeyChain.load(forKey: .userID) else { return nil }

            return String(data: data, encoding: .utf8)
        }
        set {
            guard let data = newValue?.data(using: .utf8) else { return }

            KeyChain.save(forKey: .userID, data: data)
        }
    }
    
    static var kai: KAIRemote? {
        get {
            guard let data = KeyChain.load(forKey: .kaiInfo), let jsonString = String(data: data, encoding: .utf8) else { return nil }
            
            return Helper.toObject(ofType: KAIRemote.self, jsonString: jsonString)
        }
        set {
            guard let data = Helper.toJSONString(newValue)?.data(using: .utf8) else { return }
            
            KeyChain.save(forKey: .kaiInfo, data: data)
        }
    }
    
    class func refresh() {
        AccountManagement.token = nil
        AccountManagement.userId = nil
    }
    
    class func getInfoUser(_ completion: @escaping (APIResult<AccountInfoRemote, APIErrorResult>) -> Void) {
        UserServices.getInfo() {
            switch $0 {
            case .success(let result):
                if let data = result.data {
                    AccountManagement.userId = data.user?.id
                    AccountManagement.kai = data.kai
                    completion(.success(data))
                } else {
                    completion(.failure(APIErrorResult(with: .emptyResults)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    class func login(with email: String, and password: String, _ completion: @escaping (APIResult<AccountInfoRemote, APIErrorResult>) -> Void) {
        UserServices.login(email: email, password: password) {
            switch $0 {
            case .success(let result):
                if let data = result.data {
                    AccountManagement.token = data.accessToken
                    AccountManagement.getInfoUser {
                        switch $0 {
                        case .success(let info):
                            completion(.success(info))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                } else {
                    completion(.failure(APIErrorResult(with: .emptyResults)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    class func register(username: String, email: String, password: String, _ completion: @escaping (APIResult<AccountInfoRemote, APIErrorResult>) -> Void) {
        UserServices.register(username: username, email: email, password: password) {
            switch $0 {
            case .success(let result):
                if let data = result.data {
                    AccountManagement.token = data.accessToken
                    AccountManagement.getInfoUser {
                        switch $0 {
                        case .success(let info):
                            completion(.success(info))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                } else {
                    completion(.failure(APIErrorResult(with: .emptyResults)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
