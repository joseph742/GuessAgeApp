//
//  UserLogicController.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 29/11/2021.
//

import Foundation
import Combine


protocol UsersLogicControllerProtocol: AnyObject {
    var requestController: RequestControllerProtocol { get }
    
    func getUsers() -> AnyPublisher<UserList, CustomError>
    func getUser(id: String) -> AnyPublisher<User, CustomError>
    func addUser(result: Result) -> AnyPublisher<Datum, CustomError>
}


final class UsersLogicController: UsersLogicControllerProtocol {
    
    var requestController: RequestControllerProtocol
    
    init(requestController: RequestControllerProtocol) {
        self.requestController = requestController
    }
    
    func getUsers() -> AnyPublisher<UserList, CustomError> {
        let endPoint = DummyEndPoint.users
        return requestController.execute(type: UserList.self, endPoint)
    }
    
    func getUser(id: String) -> AnyPublisher<User, CustomError> {
        let endPoint = DummyEndPoint.user(id: id)
        return requestController.execute(type: User.self, endPoint)
    }
    
    func addUser(result: Result) -> AnyPublisher<Datum, CustomError> {
        let endPoint = DummyEndPoint.addUser(result: result)
        return requestController.execute(type: Datum.self, endPoint)
    }
}
