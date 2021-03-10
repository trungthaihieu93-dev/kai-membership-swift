//
//  NewPasswordViewModel.swift
//  KAI Membership
//
//  Created by DAKiet on 10/03/2021.
//

import RxSwift

class NewPasswordViewModel {
    
    // MARK: Methods
    func confirmPassword(with token: String, password: String) -> Observable<Void> {
        return Observable.create { (observer) -> Disposable in
            UserServices.confirmPassword(with: token, password: password) {
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
