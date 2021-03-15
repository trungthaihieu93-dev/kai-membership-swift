//
//  AccountManagement.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 18/02/2021.
//

import Foundation

class AccountManagement {
    
    static var isLoggedIn: Bool {
        return AccountManagement.accessToken != nil //&& AccountManagement.userId != nil
    }
    
    static var accessToken: String? {
        get {
            guard let data = KeyChain.load(forKey: .authorizationToken) else { return nil }

            return String(data: data, encoding: .utf8)
        }
        set {
            guard let data = newValue?.data(using: .utf8) else { return }

            KeyChain.save(forKey: .authorizationToken, data: data)
        }
    }
    
    static var refreshToken: String? {
        get {
            guard let data = KeyChain.load(forKey: .refreshToken) else { return nil }

            return String(data: data, encoding: .utf8)
        }
        set {
            guard let data = newValue?.data(using: .utf8) else { return }

            KeyChain.save(forKey: .refreshToken, data: data)
        }
    }
    
    static var userID: String? {
        get {
            guard let data = KeyChain.load(forKey: .userID) else { return nil }

            return String(data: data, encoding: .utf8)
        }
        set {
            guard let data = newValue?.data(using: .utf8) else { return }

            KeyChain.save(forKey: .userID, data: data)
        }
    }
    
    static var email: String? {
        get {
            guard let data = KeyChain.load(forKey: .email) else { return nil }

            return String(data: data, encoding: .utf8)
        }
        set {
            guard let data = newValue?.data(using: .utf8) else { return }

            KeyChain.save(forKey: .email, data: data)
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
        AccountManagement.accessToken = nil
        AccountManagement.refreshToken = nil
    }
    
    class func logout() {
        AccountManagement.email = nil
        AccountManagement.userID = nil
        refresh()
    }
    
    class func getInfoUser(_ completion: @escaping (APIResult<AccountInfoRemote, APIErrorResult>) -> Void) {
        UserServices.getInfo() {
            switch $0 {
            case .success(let result):
                if let data = result.data {
                    AccountManagement.userID = data.user?.id
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
                    AccountManagement.accessToken = data.accessToken
                    AccountManagement.refreshToken = data.refreshToken
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
                    AccountManagement.accessToken = data.accessToken
                    AccountManagement.refreshToken = data.refreshToken
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
    
    class func loginWithPascode(with email: String, and passcode: String, _ completion: @escaping (APIResult<AccountInfoRemote, APIErrorResult>) -> Void) {
        DeviceServices.loginWithPasscode(passcode, email: email) {
            switch $0 {
            case .success(let result):
                if let data = result.data {
                    AccountManagement.accessToken = data.accessToken
                    AccountManagement.refreshToken = data.refreshToken
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
