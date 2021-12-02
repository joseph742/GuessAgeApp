//
//  UserLogicController.swift
//  GuessAgeApp
//
//  Created by Qasim Ahmed on 29/11/2021.
//

import Foundation
import Combine


protocol UsersLogicControllerProtocol: AnyObject {
    var networkController: NetworkControllerProtocol { get }
    
    func getUsers() -> AnyPublisher<UserList, APIError>
    func getUser(id: String) -> AnyPublisher<User, APIError>
    func addUser(result: Result) -> AnyPublisher<Datum, APIError>
}


final class UsersLogicController: UsersLogicControllerProtocol {
    
    var networkController: NetworkControllerProtocol
    
    init(networkController: NetworkControllerProtocol) {
        self.networkController = networkController
    }
    
    func getUsers() -> AnyPublisher<UserList, APIError> {
        let endPoint = DummyEndPoint.users
        return networkController.request(type: UserList.self, components: endPoint.components, headers: endPoint.headers)
    }
    
    func getUser(id: String) -> AnyPublisher<User, APIError> {
        let endPoint = DummyEndPoint.user(id: id)
        return networkController.request(type: User.self, components: endPoint.components, headers: endPoint.headers)
    }
    
    func addUser(result: Result) -> AnyPublisher<Datum, APIError> {
        let endPoint = DummyEndPoint.addUser(result: result)
        return networkController.post(type: Datum.self, components: endPoint.components, headers: endPoint.headers, body: endPoint.queryItems)
    }
}
