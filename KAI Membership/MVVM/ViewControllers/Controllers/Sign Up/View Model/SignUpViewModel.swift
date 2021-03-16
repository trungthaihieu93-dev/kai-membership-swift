//
//  SignUpViewModel.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 07/03/2021.
//

import RxSwift

class SignUpViewModel {
    
    // MARK: Methods
    func register(username: String, email: String, password: String) -> Observable<AccountInfoRemote> {
        return Observable<AccountInfoRemote>.create { (observer) -> Disposable in
            AccountManagement.register(username: username, email: email, password: password) {
                switch $0 {
                case .success(let result):
                    observer.onNext(result)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }

            return Disposables.create()
        }
    }
    
    func generateCaptcha() -> Observable<URL> {
        return Observable<URL>.create { (observer) -> Disposable in
            CaptchaServices.generateCaptcha {
                switch $0 {
                case .success(let result):
                    if let captchaID = result.data?.id, !captchaID.isEmpty, let url = URL(string: CaptchaServices.getCaptchaImageLink(with: captchaID)) {
                        observer.onNext(url)
                        observer.onCompleted()
                    } else {
                        let error = APIErrorResult(code: "1", message: "ERROR")
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }

            return Disposables.create()
        }
    }
}
