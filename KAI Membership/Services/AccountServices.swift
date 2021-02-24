//
//  AccountServices.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 24/02/2021.
//

import Foundation

class AccountServices {
    
    class func testMetadata() {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/metadata")
        
        APIServices.request(input: input, output: APIOutput.self) {
            debugPrint("Output: \($0.output)")
            debugPrint("\n\n")
            debugPrint("Response: \($0.response)")
        }
    }
}
