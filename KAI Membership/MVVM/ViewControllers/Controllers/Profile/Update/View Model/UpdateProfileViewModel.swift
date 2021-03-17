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
    func udpateProfile(name: String, phoneNumber: String) -> Observable<Void> {
        let birthday = self.birthday
        return Observable.create { (observer) -> Disposable in
            UserServices.updateInfomation(name: name, phoneNumber: phoneNumber, birthday: birthday) {
                switch $0 {
                case .success:
                    observer.onNext(())
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
