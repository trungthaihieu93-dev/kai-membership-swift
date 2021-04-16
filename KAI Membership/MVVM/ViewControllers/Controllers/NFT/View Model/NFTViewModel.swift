//
//  NFTViewModel.swift
//  KAI Membership
//
//  Created by DAKiet on 16/04/2021.
//

import RxSwift

class NFTViewModel {
    
    // MARK: Properties
    
    // MARK: Methods
    func getPet() -> Observable<Void> {
        return Observable<Void>.create { [weak self] observer -> Disposable in
            NFTServices.getPet(with: AccountManagement.accountID) {
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
