//
//  TransactionServices.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 02/03/2021.
//

import Foundation

class TransactionServices {
    
    // MARK: Get transactions
    class func getTransactions(_ completion: @escaping (APIResult<APIDataListResults<TransactionRemote>, APIErrorResult>) -> Void) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/transactions", method: .get)
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
}
