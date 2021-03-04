//
//  QuestServices.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 05/03/2021.
//

import Foundation

class QuestServices {
    
    // MARK: Get the quests list
    class func getList(_ completion: @escaping (APIResult<APIDataListResults<QuestRemote>, APIErrorResult>) -> Void) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/quests", method: .get)
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
}
