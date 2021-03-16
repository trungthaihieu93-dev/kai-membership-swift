//
//  OverviewViewModel.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 04/03/2021.
//

import RxSwift

class OverviewViewModel {
    
    // MARK: Properties
    let amount: Amount
    let address: String
    let phoneNumber: String
    let providerCode: String
    
    // MARK: Life cycle's
    init(address: String, amount: Amount) {
        self.address = address
        self.amount = amount
        self.phoneNumber = ""
        self.providerCode = ""
    }
    
    init(phoneNumber: String, providerCode: String, amount: Amount) {
        self.address = ""
        self.phoneNumber = phoneNumber
        self.providerCode = providerCode
        self.amount = amount
    }
    
    // MARK: Methods
    func createTopup() -> Observable<Void> {
        let phone = self.phoneNumber
        let providerCode = self.providerCode
        let money = self.amount.money
        return Observable.create { (observer) -> Disposable in
            TransactionServices.topup(phoneNumber: phone, providerCode: providerCode, amount: money) {
                switch $0 {
                case .success(let result):
                    debugPrint("")
                case .failure(let error):
                    observer.onError(error)
                }
            }

            return Disposables.create()
        }
    }
}
