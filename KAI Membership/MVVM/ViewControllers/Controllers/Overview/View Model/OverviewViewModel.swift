//
//  OverviewViewModel.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 04/03/2021.
//

import RxSwift
import RxRelay

class OverviewViewModel {
    
    // MARK: Properties
    let amount: Amount
    let address: String
    let phoneNumber: String
    let providerCode: String
    
    let showLoading = BehaviorRelay<Bool>(value: false)
    
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
        
        showLoading.accept(true)
        return Observable.create { [weak self] observer -> Disposable in
            TransactionServices.topup(phoneNumber: phone, providerCode: providerCode, amount: money) {
                switch $0 {
                case .success:
                    observer.onNext(())
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
                
                self?.showLoading.accept(false)
            }

            return Disposables.create()
        }
    }
    
    func createSend() -> Observable<Bool> {
        let walletAddress = self.address
        let kai = self.amount.kai
        
        showLoading.accept(true)
        return Observable.create { [weak self] observer -> Disposable in
            AccountManagement.sendKAI(walletAddress: walletAddress, kai: kai) {
                switch $0 {
                case .success:
                    QuestServices.checkMissionCompleted(userID: AccountManagement.accountID, key: .sendKai) {
                        switch $0 {
                        case .success(let result):
                            if result.data == true {
                                observer.onNext(false)
                            } else {
                                self?.requestUserQuest()
                                observer.onNext(true)
                            }
                            
                            observer.onCompleted()
                        case .failure:
                            self?.requestUserQuest()
                            observer.onNext((true))
                            observer.onCompleted()
                        }
                        
                        self?.showLoading.accept(false)
                    }
                case .failure(let error):
                    observer.onError(error)
                    self?.showLoading.accept(false)
                }
            }

            return Disposables.create()
        }
    }
    
    func requestUserQuest() {
        QuestServices.requestUserQuest(with: .sendKai) {
            switch $0 {
            case .success:
                AlertManagement.shared.showToast(with: "🎁 You have 01 free spin", position: .top)
                NotificationCenter.default.post(name: .requestQuestSuccess, object: QuestKey.sendKai)
            case .failure:
                AlertManagement.shared.showToast(with: "🤔 Request incorrect!", position: .top)
            }
        }
    }
}
