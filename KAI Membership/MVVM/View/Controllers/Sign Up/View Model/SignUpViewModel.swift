//
//  SignUpViewModel.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 07/03/2021.
//

import RxSwift

class SignUpViewModel {
    
    // MARK: Properties
    private(set) var email: String?
    private(set) var password: String?
    private(set) var confirmPass: String?
    
    // MARK: Methods
    func updateEmail(_ email: String? = nil) {
        self.email = email
    }
    
    // TODO: Update password
    func updatePassword(_ password: String? = nil) {
        self.password = password
    }
    
    // TODO: Confirm password
    func confirmPassword(_ password: String? = nil) {
        self.confirmPass = password
    }
    
    // TODO: Login
    func login(with email: String, and password: String) -> Observable<LoginRemote?> {
        return Observable<LoginRemote?>.create { (observer) -> Disposable in
            UserServices.login(email: email, password: password) {
                switch $0 {
                case .success(let result):
                    observer.onNext(result.data)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
