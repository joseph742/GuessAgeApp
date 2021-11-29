//
//  RandomUserLogicController.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 26/11/2021.
//

import Foundation
import Combine
import UIKit

protocol UsersLogicControllerProtocol: AnyObject {
    var networkController: NetworkControllerProtocol { get }
    
    func getUser() -> AnyPublisher<RandomUser, APIError>
    
}


final class RandomUserLogicController: UsersLogicControllerProtocol {
    
    var networkController: NetworkControllerProtocol
    
    init(networkController: NetworkControllerProtocol) {
        self.networkController = networkController
    }
    
    func getUser() -> AnyPublisher<RandomUser, APIError> {
        let endPoint = RandomUserEndPoint.user
        return networkController.request(type: RandomUser.self, components: endPoint.components, headers: endPoint.headers)
    }
    
}
