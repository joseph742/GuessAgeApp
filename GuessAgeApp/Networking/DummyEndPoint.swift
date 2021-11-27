//
//  DummyEndPoint.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 25/11/2021.
//

import Foundation

struct DummyEndPoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}


extension DummyEndPoint {
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dummyapi.io"
        components.path = "/data/v1" + path
        components.queryItems = queryItems
        
        components.queryItems = [
          URLQueryItem(name: "created", value: "1"),
        ]
        
        return components
    }
    
    var headers: [String: Any] {
        return [
            "app-id": "615d4b92dbf0d4a4759c1740",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
    }
}

extension DummyEndPoint {
    static var users: Self {
        return DummyEndPoint(path: "/user")
    }
    
    static func users(id: String) -> Self {
        return DummyEndPoint(path: "/user/\(id)")
    }
}
