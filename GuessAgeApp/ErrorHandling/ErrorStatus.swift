//
//  ErrorStatus.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 02/12/2021.
//

import Foundation

enum ErrorStatus: String {
    
    case badRequest = "Bad request"
    case failed = "Network request failed."
    case redirect = "This request has been redirected."
    case success = "Success"
    case unableToDecode = "We could not decode the response."
    case unauthorized = "You need to be authenticated first."
    case invalidParameters = "Invalid parameters"
    case invalidURL = "Invalid url"
    
}
