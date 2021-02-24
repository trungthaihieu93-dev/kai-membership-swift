//
//  MissionViewController.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 23/02/2021.
//

import UIKit
import Alamofire
import RxSwift

class MissionViewController: BaseViewController {
    
    lazy var disposeBag = DisposeBag()
    
    // MARK: Life cycle's
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        AF.request("https://reviewapi.riviu.co/metadata").responseJSON { response in
//            debugPrint(response)
//            let result = response.data
//            
//            do {
//                let configures = try JSONDecoder().decode([Test].self, from: result!)
//                
//                debugPrint(configures)
//            } catch {
//                debugPrint("Error")
//            }
//        }
        
        AccountRemoteDataSource.get().subscribe(on: MainScheduler.instance).subscribe(onNext: { [weak self] account in
            debugPrint("")
        }).disposed(by: disposeBag)
        
    }
}

struct Test: Codable {
    let key: String
    let value: String
}
