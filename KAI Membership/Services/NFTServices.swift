//
//  NFTServices.swift
//  KAI Membership
//
//  Created by DAKiet on 16/04/2021.
//

import Foundation

class NFTServices {
    
    // MARK: Get pet
    class func getPet(with userID: String, _ completion: ((APIResult<APIDataResults<String>, APIErrorResult>) -> Void)? = nil) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/nft_pets/\(userID)", method: .get)
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
}
