//
//  UpdateProfileViewModel.swift
//  KAI Membership
//
//  Created by DAKiet on 10/03/2021.
//

import RxSwift

class UpdateProfileViewModel {
    
    // MARK: Properties
    private let fullNameDefault: String
    private let birthdayDefault: Double?
    private let phoneNumberDefault: String
    
    var fullName: String = ""
    var birthday: Double?
    var phoneNumber: String = ""
    
    var hasChanged: Bool {
        if let birthdayDefault = self.birthdayDefault {
            return fullName != fullNameDefault && phoneNumber != phoneNumberDefault && !fullName.isEmpty && !phoneNumber.isEmpty && birthday != birthdayDefault
        } else {
            return fullName != fullNameDefault && phoneNumber != phoneNumberDefault && !fullName.isEmpty && !phoneNumber.isEmpty
        }
    }
    
    // MARK: Life cycle's
    init(fullName: String? = nil, birthday: Double? = nil, phoneNumber: String? = nil) {
        self.fullNameDefault = fullName ?? ""
        self.birthdayDefault = birthday
        self.phoneNumberDefault = phoneNumber ?? ""
    }
    
    // MARK: Methods
    func udpateProfile() -> Observable<Void> {
        let birthday = self.birthday
        let fullName = self.fullName
        let phoneNumber = self.phoneNumber
        
        return Observable.create { (observer) -> Disposable in
            UserServices.updateInfomation(name: fullName, phoneNumber: phoneNumber, birthday: birthday) {
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
}
