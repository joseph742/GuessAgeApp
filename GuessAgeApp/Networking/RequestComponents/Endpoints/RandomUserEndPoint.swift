//
//  RandomUserEndPoint.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 25/11/2021.
//

import Foundation


struct RandomUserEndPoint: Endpoint {
    
    var host: String { RandomUserAPIConfig.host }
    
    var path: String
    
    var httpMethod: HTTPMethod
    
    var task: HTTPTask
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json"]
    }
}


extension RandomUserEndPoint {
    static var user: Self {
        
        return RandomUserEndPoint(path: "api/1.3/", httpMethod: .get, task: .request())
    }
}
