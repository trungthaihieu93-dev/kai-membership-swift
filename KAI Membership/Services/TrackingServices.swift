//
//  TrackingServices.swift
//  KAI Membership
//
//  Created by DAKiet on 12/03/2021.
//

import Foundation

class TrackingServices {
    
    // MARK: Get a list of accounts that have been logged in to the device
    class func getAccountsLoggedIntoDevice(_ completion: @escaping (APIResult<APIDataResults<DeviceRemote>, APIErrorResult>) -> Void) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/trackings", method: .post)
        input.params["type_tracking"] = "GAME"
        input.params["description"] = "Flying bird"
        input.params["device_id"] = Constants.Device.id
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
}
