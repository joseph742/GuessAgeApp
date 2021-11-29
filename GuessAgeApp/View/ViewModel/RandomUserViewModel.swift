//
//  RandomUserViewModel.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 27/11/2021.
//

import Foundation
import Combine
import UIKit

class RandomUserViewModel: ObservableObject {
    @Published var randomUserData: RandomUser?
    @Published var birthYear = 0
    @Published var showYearSelector = false
    @Published var showSuccessOrFailureView = false
    @Published var successOrFailure = false
    @Published var message = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        fetchRandomUser()
        
        $birthYear
            .map { [unowned self] yearSelected in
                if let userAge = self.randomUserData?.results[0].dob.age, let gender = self.randomUserData?.results[0].gender, yearSelected > 0 {
                    
                    if (userAge - 8)...(userAge + 8) ~= yearSelected {
                        successOrFailure = true
                        message = "Congratulations \(getGenderPronoun(gender: gender)) is \(userAge) years old"
                        birthYear = 0
                    } else {
                        successOrFailure = false
                        message = "Sorry \(getGenderPronoun(gender: gender)) is \(userAge) years old"
                        birthYear = 0
                    }
                    
                    return true
                } else {
                    return false
                }
            }
            .assign(to: \.showSuccessOrFailureView, on: self)
            .store(in: &subscriptions)
        
    }
    
    func fetchRandomUser() {
        let networkController = NetworkController()
        let logicController = RandomUserLogicController(networkController: networkController)
        logicController
            .getUser()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                    
                case .finished:
                    break
                }
            } receiveValue: { [unowned self] randomUser in
                self.randomUserData = randomUser
                birthYear = 0
                
            }
            .store(in: &subscriptions)

    }
    
    func getGenderPronoun(gender: String) -> String {
        switch gender {
        case "male":
            return "he"
        default:
            return "she"
        }
    }
}
