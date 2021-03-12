//
//  PasscodeServices.swift
//  KAI Membership
//
//  Created by DAKiet on 12/03/2021.
//

import Foundation

class PasscodeServices {
    
    // MARK: Reset passcode
    class func requestResetPasscode(with email: String, _ completion: ((APIResult<APIDataResults<String>, APIErrorResult>) -> Void)? = nil) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/passcode/forgot", method: .post)
        input.params["email"] = email
        input.params["mobile_unique_id"] = Constants.Device.id
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
}
