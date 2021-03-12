//
//  DeviceServices.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 03/03/2021.
//

import Foundation

class DeviceServices {
    
    // MARK: Get a list of accounts that have been logged in to the device
    class func getAccountsLoggedIntoDevice(_ completion: @escaping (APIResult<APIDataResults<DeviceRemote>, APIErrorResult>) -> Void) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/devices/\(Constants.Device.id)", method: .get)
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
    
    // MARK: Login with passcode
    class func loginWithPasscode(_ passcode: String, email: String, _ completion: @escaping (APIResult<APIDataResults<DeviceRemote>, APIErrorResult>) -> Void) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/passcodes/login", method: .post)
        input.params["passcode"] = passcode
        input.params["email"] = email
        input.params["device_id"] = Constants.Device.id
        input.params["os"] = "ios"
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
    
    // MARK: Create passcode
    class func createPasscode(with email: String, passcode: String, _ completion: @escaping (APIResult<APIDataResults<String>, APIErrorResult>) -> Void) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/passcodes/register", method: .post)
        input.params["device_id"] = Constants.Device.id
        input.params["passcode"] = passcode
        input.params["refresh_token"] = AccountManagement.refreshToken
        input.params["email"] = email
        input.params["os"] = "ios"
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
}
