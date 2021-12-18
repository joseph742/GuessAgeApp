//
//  UserViewModel.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 29/11/2021.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    @Published var users: UserList?
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        let requestController = RequestController()
        let userLogicController = UsersLogicController(requestController: requestController)
        
        userLogicController
            .getUsers()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { value in
                switch value {
                case .failure(let error):
                    print("Couldn't get users: \(error.localizedDescription)")
                    
                case .finished: break
                }
            }, receiveValue: { [weak self] users in
                guard let self = self else { return }
                self.users = users
            })
            .store(in: &subscriptions)

    }
}
