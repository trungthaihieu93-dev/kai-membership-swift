//
//  MainViewModel.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 03/03/2021.
//

import RxSwift

class MainViewModel {
    
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
}
