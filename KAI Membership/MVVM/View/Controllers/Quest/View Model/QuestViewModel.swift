//
//  QuestViewModel.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 05/03/2021.
//

import RxSwift

class QuestViewModel {
    
    // MARK: Properties
    private var quests = [QuestRemote]()
    
    private(set) var dailyQuests = [QuestRemote]()
    private(set) var monthlyQuests = [QuestRemote]()
    
    // MARK: Methods
    func getTheQuestsList() -> Observable<[QuestRemote]> {
        return Observable<[QuestRemote]>.create { (observer) -> Disposable in
            QuestServices.getList { [weak self] in
                switch $0 {
                case .success(let result):
                    self?.setData(result.datas)
                    observer.onNext(result.datas)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
        
    private func setData(_ results: [QuestRemote]) {
        quests = results
        dailyQuests = results.filter { $0.type == .daily }
        monthlyQuests = results.filter { $0.type == .monthly }
    }
}
