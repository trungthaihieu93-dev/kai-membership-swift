//
//  PasscodeViewModel.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 04/03/2021.
//

import RxSwift

class PasscodeViewModel {
    
    // MARK: Properties
    let email: String
    
    // MARK: Life cycle's
    init(email: String) {
        self.email = email
    }
    
    // MARK: Methods
    func loginWithPasscode(_ passcode: String) -> Observable<Void> {
        let email = self.email
        
        return Observable<Void>.create { (observer) -> Disposable in
            DeviceServices.loginWithPasscode(passcode, email: email) {
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
    
    func createPasscode(_ passcode: String) -> Observable<Void> {
        let email = self.email
        
        return Observable<Void>.create { (observer) -> Disposable in
            DeviceServices.createPasscode(with: email, passcode: passcode) {
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
