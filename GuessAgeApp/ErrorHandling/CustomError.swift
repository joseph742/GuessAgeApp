//
//  CustomError.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 02/12/2021.
//

import Foundation

struct CustomError: Decodable, Error, LocalizedError {
    
    var error: String
    var errorDescription: String?
    
    init(error: String) {
        
        self.error = error
        self.errorDescription = error
        
    }
    
    init(statusCode: Int) {
        
        switch statusCode {
        case 200...299:
            self.error = ErrorStatus.success.rawValue
            self.errorDescription = ErrorStatus.success.rawValue
        case 300...399:
            self.error = ErrorStatus.redirect.rawValue
            self.errorDescription = ErrorStatus.redirect.rawValue
        case 401...500:
            self.error = ErrorStatus.unauthorized.rawValue
            self.errorDescription = ErrorStatus.unauthorized.rawValue
        case 400, 501...599:
            self.error = ErrorStatus.badRequest.rawValue
            self.errorDescription = ErrorStatus.badRequest.rawValue
        default:
            self.error = ErrorStatus.failed.rawValue
            self.errorDescription = ErrorStatus.failed.rawValue
        }
        
    }
    
    init(status: ErrorStatus) {
        
        self.error = status.rawValue
        self.errorDescription = status.rawValue
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        error = try container.decode(String.self, forKey: .error)
        errorDescription = try container.decode(String.self, forKey: .error)
    }
    
    enum CodingKeys: String, CodingKey {
        
        case error, errorDescription
        
    }
    
    static func convert(error: Error) -> CustomError {
        
        switch error {
        case is CustomError:
            return error as! CustomError
        default:
            return CustomError(error: error.localizedDescription)
        }
    }
}
