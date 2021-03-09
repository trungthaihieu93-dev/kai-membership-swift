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
    
    class func getInfo(_ completion: @escaping (APIResult<APIDataResults<AccountInfoRemote>, APIErrorResult>) -> Void) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/users/info", method: .get)
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
    
    class func register(username: String, email: String, password: String, _ completion: @escaping (APIResult<APIDataResults<LoginRemote>, APIErrorResult>) -> Void) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/auth/register", method: .post)
        input.params["username"] = username
        input.params["password"] = password
        input.params["email"] = email
        input.params["first_name"] = "firstName"
        input.params["last_name"] = "lastName"
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
}
