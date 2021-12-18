//
//  RandomUserAPIConfig.swift
//  GuessAgeApp
//
//  Created by Qasim Ahmed on 02/12/2021.
//

import Foundation

struct RandomUserAPIConfig {
    
    static let environment: APIEnvironment = .production
    static var host: String {
        switch environment {
            case .production: return "https://randomuser.me/"
            case .staging: return "https://randomuser.me/"
            
        }
        
    }
 
}
