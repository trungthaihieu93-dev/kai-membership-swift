//
//  OverviewViewModel.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 04/03/2021.
//

import RxSwift

class OverviewViewModel {
    
    // MARK: Properties
    private let amount: Double
    private let address: String
    private let phoneNumber: String
    private let serviceProvider: String
    
    // MARK: Life cycle's
    init(address: String, amount: Double) {
        self.address = address
        self.amount = amount
        self.phoneNumber = ""
        self.serviceProvider = ""
    }
    
    init(phoneNumber: String, serviceProvider: String, amount: Double) {
        self.address = ""
        self.phoneNumber = phoneNumber
        self.serviceProvider = serviceProvider
        self.amount = amount
    }
}
