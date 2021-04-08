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
    
    // MARK: Get the quests list of user
    class func getUserQuests(_ completion: @escaping (APIResult<APIDataListResults<UserQuestRemote>, APIErrorResult>) -> Void) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/quests/users", method: .get)
        
        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
    
    // MARK: Request mission progress
    class func requestUserQuest(with key: QuestKey, _ completion: ((APIResult<APIDataResults<UserQuestRemote>, APIErrorResult>) -> Void)? = nil) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/quests", method: .post)
        input.params["key"] = key.rawValue

        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
    
    // MARK: Check mission completed
    class func checkMissionCompleted(userID: String, key: QuestKey, _ completion: @escaping (APIResult<APIDataResults<Bool>, APIErrorResult>) -> Void) {
        let input = APIInput(withDomain: Constants.environment.domain, path: "/api/v1/quests/get", method: .post)
        input.params["user_id"] = userID
        input.params["key"] = key.rawValue

        APIServices.request(input: input, output: APIOutput.self, completion: completion)
    }
}
