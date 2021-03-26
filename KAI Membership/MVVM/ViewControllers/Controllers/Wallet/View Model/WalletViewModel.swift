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
    private func getTransactions() -> Observable<[TransactionRemote]> {
        return Observable<[TransactionRemote]>.create { [weak self] observer -> Disposable in
            TransactionServices.getTransactions() {
                switch $0 {
                case .success(let result):
                    self?.transactions = result.datas
                    observer.onNext(result.datas)
                case .failure(let error):
                    debugPrint("Error get transactions: \(error.message)")
                }
                
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    private func getUserInfo() -> Observable<AccountInfoRemote> {
        return Observable<AccountInfoRemote>.create { observer -> Disposable in
            AccountManagement.getInfoUser {
                switch $0 {
                case .success(let info):
                    observer.onNext(info)
                case .failure(let error):
                    debugPrint("Error get user infomation: \(error.message)")
                }
                
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func fetchData() -> Observable<([TransactionRemote], AccountInfoRemote)> {
        let transactions = getTransactions()
        let user = getUserInfo()
        
        return Observable.combineLatest(transactions, user)
    }
}
