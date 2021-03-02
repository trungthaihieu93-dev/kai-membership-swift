//
//  UserServices.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 24/02/2021.
//

import Foundation

class UserServices {
    
    // MARK: Login
    class func login(email: String, password: String, _ completion: @escaping (APIResult<APIDataResults<AccountRemote>, APIErrorResult>) -> Void) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/auth/login", method: .post)
        input.params["os"] = "ios"
        input.params["username"] = email
        input.params["password"] = password
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
}
