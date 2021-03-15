//
//  UserServices.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 24/02/2021.
//

import Foundation

class UserServices {
    
    // MARK: Login
    class func login(email: String, password: String, _ completion: @escaping (APIResult<APIDataResults<LoginRemote>, APIErrorResult>) -> Void) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/auth/login", method: .post)
        input.params["os"] = "ios"
        input.params["username"] = email
        input.params["password"] = password
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
    
    // MARK: Get infomation user
    class func getInfo(_ completion: @escaping (APIResult<APIDataResults<AccountInfoRemote>, APIErrorResult>) -> Void) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/users/info", method: .get)
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
    
    // MARK: Register
    class func register(username: String, email: String, password: String, _ completion: @escaping (APIResult<APIDataResults<LoginRemote>, APIErrorResult>) -> Void) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/auth/register", method: .post)
        input.params["username"] = username
        input.params["password"] = password
        input.params["email"] = email
        input.params["first_name"] = "firstName"
        input.params["last_name"] = "lastName"
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
        
    // MARK: Request change password with email
    class func requestChangePassword(with email: String, _ completion: @escaping (APIResult<APIDataResults<String>, APIErrorResult>) -> Void) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/auth/reset-password", method: .post)
        input.params["email"] = email
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
    
    // MARK: Confirm password when receive token from email
    class func confirmPassword(with token: String, password: String, _ completion: @escaping (APIResult<APIDataResults<String>, APIErrorResult>) -> Void) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/auth/reset-password-confirm", method: .post)
        input.params["token"] = token
        input.params["password"] = password
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
    
    // MARK: Get histories
    class func getHistories(_ completion: @escaping (APIResult<APIDataListResults<HistoryRemote>, APIErrorResult>) -> Void) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/users/history", method: .get)
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
    
    // MARK: Change password
    class func changePassword(password: String, newPassword: String, _ completion: @escaping (APIResult<APIDataResults<String>, APIErrorResult>) -> Void) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/users/change-password", method: .post)
        input.params["password"] = password
        input.params["new_password"] = newPassword
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
}
