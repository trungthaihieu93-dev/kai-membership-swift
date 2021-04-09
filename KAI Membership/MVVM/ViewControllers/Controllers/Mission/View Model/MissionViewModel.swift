//
//  MissionViewModel.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 05/03/2021.
//

import RxSwift

class MissionViewModel {
    
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
    
    func requestUserQuest(with key: QuestKey) -> Observable<Void> {
        return Observable.create { (observer) -> Disposable in
            QuestServices.requestUserQuest(with: key) {
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
    
    func checkMissionCompleted(userID: String, key: QuestKey) -> Observable<Bool> {
        return Observable<Bool>.create { (observer) -> Disposable in
            QuestServices.checkMissionCompleted(userID: userID, key: key) {
                switch $0 {
                case .success(let result):
                    observer.onNext(result.data == true)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    func verifyEmail(_ email: String) -> Observable<Void> {
        return Observable.create { (observer) -> Disposable in
            PasscodeServices.verifyEmail(with: email) {
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
    
    func requestQuestSuccess(with key: QuestKey) -> Int? {
        guard let index = quests.firstIndex(where: { $0.key == key }) else { return nil }
        
        if let userQuest = quests[index].userQuest {
            let progress = userQuest.progress ?? 0
            userQuest.progress = progress + 1
            quests[index].userQuest = userQuest
        } else {
            quests[index].progress = 0
        }
        
        return index
    }
}
