//
//  ActivityServices.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 03/03/2021.
//

import Foundation

extension String: BaseModel {
    
}

class ActivityServices {
    
    // MARK: Activity accounts
    class func activity(userId: String, _ completion: ((APIResult<APIDataResults<String>, APIErrorResult>) -> Void)? = nil) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/activity", method: .post)
        input.params["user_id"] = userId
        input.params["device_id"] = Constants.Device.id
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
}
