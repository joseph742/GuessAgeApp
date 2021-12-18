//
//  DummyAPIConfig.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 02/12/2021.
//

import Foundation

struct DummyAPIConfig {
    
    static let environment: APIEnvironment = .production
    static var host: String {
        switch environment {
            case .production: return "https://dummyapi.io/"
            case .staging: return "https://dummyapi.io/"
            
        }
        
    }
 
}
