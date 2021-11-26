//
//  RandomUserEndPoint.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 25/11/2021.
//

import Foundation


struct RandomUserEndPoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}


extension RandomUserEndPoint {
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "randomuser.me"
        components.path = "/api" + path
        components.queryItems = queryItems
        
        return components
    }
    
    var headers: [String: Any] {
        return [
            "Content-Type": "application/json"
        ]
    }
}

extension RandomUserEndPoint {
    static var user: Self {
        return RandomUserEndPoint(path: "/1.3")
    }
}
