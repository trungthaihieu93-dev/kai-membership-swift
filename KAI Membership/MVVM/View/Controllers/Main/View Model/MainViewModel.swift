//
//  MainViewModel.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 03/03/2021.
//

import RxSwift

class MainViewModel {
    
    // MARK: Methods
    private func getAccountsLoggedIntoDevice() -> Observable<DeviceRemote?> {
        return Observable<DeviceRemote?>.create { (observer) -> Disposable in
            DeviceServices.getAccountsLoggedIntoDevice {
                switch $0 {
                case .success(let result):
                    observer.onNext(result.data)
                    observer.onCompleted()
                case .failure(let error):
                    debugPrint("Get accounts logged into device error: \(error.message)")
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    private func getConfigs() -> Observable<[ConfigGroupRemote]> {
        return Observable<[ConfigGroupRemote]>.create { (observer) -> Disposable in
            ConfigServices.get {
                switch $0 {
                case .success(let result):
                    AppSetting.configures = result.datas
                    observer.onNext(result.datas)
                    observer.onCompleted()
                case .failure(let error):
                    debugPrint("Get configures error: \(error.message)")
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
  
    func getData() -> Observable<([ConfigGroupRemote], DeviceRemote?)> {
        let config = getConfigs()
        let devices = getAccountsLoggedIntoDevice()
        
        return Observable.combineLatest(config, devices)
    }
}
