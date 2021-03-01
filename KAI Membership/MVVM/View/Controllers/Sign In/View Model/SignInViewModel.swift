//
//  SignInViewModel.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 01/03/2021.
//

import RxSwift

class SignInViewModel {
    
    // MARK: Properties
    private var email: String?
    private var password: String?
    
    // MARK: Methods
    func updateEmail(_ email: String? = nil) {
        self.email = email
    }
    
    // TODO: Update password
    func updatePassword(_ password: String? = nil) {
        self.password = password
    }
    
    // TODO: Login
    func login() -> Observable<Void> {
        return Observable<Void>.create { (observer) -> Disposable in
            AccountServices.login(email: "tester", password: "tester321") {
                switch $0 {
                case .success(let result):
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
