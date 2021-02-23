//
//  MissionViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 23/02/2021.
//

import UIKit
import Alamofire

class MissionViewController: BaseViewController {
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        AF.request("https://reviewapi.riviu.co/metadata").responseJSON { response in
//            debugPrint(response)
//            let result = response.data
//            
//            do {
//                let configures = try JSONDecoder().decode([Configure].self, from: result!)
//                
//                debugPrint(configures)
//            } catch {
//                debugPrint("Error")
//            }
//        }
        
        let input = APIInput(withDomain: "https://reviewapi.riviu.co", path: "/metadata")
        
        APIServices.request(input: input, output: APIOutput.self) {
            debugPrint("Output: \($0.output)")
            debugPrint("\n\n")
            debugPrint("Response: \($0.response)")
        }
    }
}

struct Configure: Codable {
    let key: String
    let value: String
}
