//
//  KaiStarterViewModel.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 13/04/2021.
//

import RxSwift

class KaiStarterViewModel {
    
    // MARK: Properties
    private(set) var ongoingProjects: [KaiProjectRemote] = []
    private(set) var lockingProjects: [KaiProjectRemote] = []
    private(set) var completedProjects: [KaiProjectRemote] = []
    
    // MARK: Methods
    func createData() {
        ongoingProjects = [
            KaiProjectRemote(with: "1", name: "Ongoing Projects Sugar Baby 3", description: "A web drama produced by Big Cat Entertainment and broadcast on 6 million-subscribers Youtube channel - Ghien Mi Go.", current: 8700000, target: 10000000, backers: 31, imageLink: nil),
            KaiProjectRemote(with: "2", name: "Ongoing Projects Sugar Baby 2", description: "A web drama produced by Big Cat Entertainment and broadcast on 6 million-subscribers Youtube channel - Ghien Mi Go.", current: 10000000, target: 10000000, backers: 31, imageLink: nil),
            KaiProjectRemote(with: "3", name: "Ongoing Projects Futsal Prize Farming", description: "Introducing the concept of prize farming! Stake your KAI and KardiaChain Saigon FC - 3rd in previous national league.", current: 1756425.75, target: 2000000, backers: 94, imageLink: nil)
        ]
        
        lockingProjects = [
            KaiProjectRemote(with: "1", name: "Locking Projects Sugar Baby 3", description: "A web drama produced by Big Cat Entertainment and broadcast on 6 million-subscribers Youtube channel - Ghien Mi Go.", current: 8700000, target: 10000000, backers: 31, imageLink: nil),
            KaiProjectRemote(with: "2", name: "Locking Projects Sugar Baby 2", description: "A web drama produced by Big Cat Entertainment and broadcast on 6 million-subscribers Youtube channel - Ghien Mi Go.", current: 10000000, target: 10000000, backers: 31, imageLink: nil),
            KaiProjectRemote(with: "3", name: "Locking Projects Futsal Prize Farming", description: "Introducing the concept of prize farming! Stake your KAI and KardiaChain Saigon FC - 3rd in previous national league.", current: 1756425.75, target: 2000000, backers: 94, imageLink: nil)
        ]
        
        completedProjects = [
            KaiProjectRemote(with: "1", name: "Completed Projects Sugar Baby 3", description: "A web drama produced by Big Cat Entertainment and broadcast on 6 million-subscribers Youtube channel - Ghien Mi Go.", current: 8700000, target: 10000000, backers: 31, imageLink: nil),
            KaiProjectRemote(with: "2", name: "Completed Projects Sugar Baby 2", description: "A web drama produced by Big Cat Entertainment and broadcast on 6 million-subscribers Youtube channel - Ghien Mi Go.", current: 10000000, target: 10000000, backers: 31, imageLink: nil),
            KaiProjectRemote(with: "3", name: "Completed Projects Futsal Prize Farming", description: "Introducing the concept of prize farming! Stake your KAI and KardiaChain Saigon FC - 3rd in previous national league.", current: 1756425.75, target: 2000000, backers: 94, imageLink: nil)
        ]
    }
}
