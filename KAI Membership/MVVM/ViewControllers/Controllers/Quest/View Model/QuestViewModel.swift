//
//  QuestViewModel.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 05/03/2021.
//

import RxSwift

class QuestViewModel {
    
    // MARK: Properties
    private(set) var quests = [QuestRemote]()
    
    // MARK: Methods
    func getTheQuestsList() -> Observable<[QuestRemote]> {
        return Observable<[QuestRemote]>.create { (observer) -> Disposable in
            QuestServices.getList { [weak self] in
                switch $0 {
                case .success(let questResult):
                    if !questResult.datas.isEmpty, AccountManagement.isLoggedIn {
                        QuestServices.getUserQuests { [weak self] in
                            guard let this = self else {
                                observer.onCompleted()
                                return
                            }
                            
                            switch $0 {
                            case .success(let result):
                                this.quests = this.mapQuest(quests: questResult.datas, userQuests: result.datas)
                                observer.onNext(this.quests)
                                observer.onCompleted()
                            case .failure(let error):
                                observer.onError(error)
                            }
                        }
                    } else {
                        self?.quests = questResult.datas
                        observer.onNext(questResult.datas)
                        observer.onCompleted()
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
        
    private func mapQuest(quests: [QuestRemote], userQuests: [UserQuestRemote]) -> [QuestRemote] {
        let newValue = quests.compactMap { $0.screenName == "GameScreen" ? nil : $0 }
        
        for userQuest in userQuests {
            for i in 0..<newValue.count where newValue[i].key == userQuest.key {
                newValue[i].userQuest = userQuest
            }
        }
        
        return newValue
    }
}
