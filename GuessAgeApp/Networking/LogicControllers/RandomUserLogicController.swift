//
//  RandomUserLogicController.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 26/11/2021.
//

import Foundation
import Combine
import UIKit

protocol RandomUserLogicControllerProtocol: AnyObject {
    var requestController: RequestControllerProtocol { get }
    
    func getUser() -> AnyPublisher<RandomUser, CustomError>
    
}


final class RandomUserLogicController: RandomUserLogicControllerProtocol {
    
    var requestController: RequestControllerProtocol
    
    init(requestController: RequestControllerProtocol) {
        self.requestController = requestController
    }
    
    func getUser() -> AnyPublisher<RandomUser, CustomError> {
        let endPoint = RandomUserEndPoint.user
        return requestController.execute(type: RandomUser.self, endPoint)
    }
    
}
