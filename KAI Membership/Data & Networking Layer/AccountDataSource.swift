//
//  File.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 24/02/2021.
//

import RxSwift

class AccountRemoteDataSource {
    
    class func get() -> Observable<AccountRemote> {
        return Observable<AccountRemote>.create({ (observer) -> Disposable in
            AccountServices.testMetadata()
            
            // Can hoan chinh
            
            return Disposables.create()
        })
    }
    
    // Saves the Object data into Realm
    class func save(_ remote: AccountRemote) {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let object = remote.toDataLocal()
                
                RealmServices.shared.create(object)
            }
        }
    }
}

class AccountLocalDataSource {
    
    // Fetches the data from Realm and returns an Object
    class func get(with uuid: String) -> AccountLocal? {
        let localData = RealmServices.shared.get(ofType: AccountLocal.self, forPrimaryKey: uuid)
        
        return localData
    }
    
    // Saves the Object data into Realm
    class func save(_ object: AccountLocal) {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                RealmServices.shared.create(object)
            }
        }
    }
}
