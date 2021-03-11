//
//  ResetPasswordViewModel.swift
//  KAI Membership
//
//  Created by DAKiet on 11/03/2021.
//

import RxSwift

class ResetPasswordViewModel {
    
    // MARK: Methods
    func requestResetPassword(with email: String) -> Observable<Void> {
        return Observable.create { (observer) -> Disposable in
            UserServices.requestChangePassword(with: email) {
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
