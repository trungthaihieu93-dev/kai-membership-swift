//
//  KaiStarterProjectViewModel.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 05/04/2021.
//

import RxSwift

class KaiStarterProjectViewModel {
    
    // MARK: Properties
    private(set) var projects: [KaiProjectRemote] = []
    
    // MARK: Methods
    func createData() {
        projects = [
            KaiProjectRemote(with: "1", name: "Sugar Baby 3", description: "A web drama produced by Big Cat Entertainment and broadcast on 6 million-subscribers Youtube channel - Ghien Mi Go.", current: 8700000, target: 10000000, backers: 31, imageLink: nil),
            KaiProjectRemote(with: "2", name: "Sugar Baby 2", description: "A web drama produced by Big Cat Entertainment and broadcast on 6 million-subscribers Youtube channel - Ghien Mi Go.", current: 10000000, target: 10000000, backers: 31, imageLink: nil),
            KaiProjectRemote(with: "3", name: "Futsal Prize Farming", description: "Introducing the concept of prize farming! Stake your KAI and KardiaChain Saigon FC - 3rd in previous national league.", current: 1756425.75, target: 2000000, backers: 94, imageLink: nil)
        ]
    }
}
