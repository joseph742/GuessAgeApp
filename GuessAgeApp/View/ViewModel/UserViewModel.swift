//
//  UserViewModel.swift
//  GuessAgeApp
//
//  Created by Qasim Ahmed on 29/11/2021.
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
        let networkController = NetworkController()
        
        let userLogicController = UsersLogicController(networkController: networkController)
        
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
                print(users)
            })
            .store(in: &subscriptions)

    }
}
