//
//  UpdateProfileViewModel.swift
//  KAI Membership
//
//  Created by DAKiet on 10/03/2021.
//

import RxSwift

class UpdateProfileViewModel {
    
    // MARK: Properties
    var birthday: Double?
    
    // MARK: Methods
    func login(with email: String, and password: String) -> Observable<AccountInfoRemote> {
        return Observable<AccountInfoRemote>.create { (observer) -> Disposable in
            AccountManagement.login(with: email, and: password) {
                switch $0 {
                case .success(let info):
                    observer.onNext(info)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
