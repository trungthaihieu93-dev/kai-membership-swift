//
//  ProfileViewModel.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 14/03/2021.
//

import RxSwift

class ProfileViewModel {
    
    // MARK: Methods
    func getAccountsLoggedIntoDevice() -> Observable<DeviceRemote?> {
        return Observable<DeviceRemote?>.create { (observer) -> Disposable in
            DeviceServices.getAccountsLoggedIntoDevice {
                switch $0 {
                case .success(let result):
                    observer.onNext(result.data)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    func getUserInfo() -> Observable<UserRemote> {
        return Observable<UserRemote>.create { (observer) -> Disposable in
            AccountManagement.getInfoUser {
                switch $0 {
                case .success(let result):
                    if let user = result.user {
                        observer.onNext(user)
                    } else {
                        observer.onNext(AccountManagement.user)
                    }
                    
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
