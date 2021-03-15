//
//  WalletViewModel.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 02/03/2021.
//

import RxSwift

class WalletViewModel {
    
    // MARK: Properties
    private(set) var transactions = [TransactionRemote]()
    
    // MARK: Methods

    // TODO: Get transactions
    func getTransactions() -> Observable<[TransactionRemote]> {
        return Observable<[TransactionRemote]>.create { [weak self] observer -> Disposable in
            TransactionServices.getTransactions() {
                switch $0 {
                case .success(let result):
                    self?.transactions = result.datas
                    observer.onNext(result.datas)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
