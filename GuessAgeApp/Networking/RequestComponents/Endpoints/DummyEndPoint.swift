//
//  DummyEndPoint.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 25/11/2021.
//

import Foundation

struct DummyEndPoint: Endpoint {
    var path: String
    
    var httpMethod: HTTPMethod
    
    var task: HTTPTask
    
    var headers: HTTPHeaders? {
        return ["app-id": "615d4b92dbf0d4a4759c1740", "Content-Type": "application/x-www-form-urlencoded"]
    }
}

extension DummyEndPoint {
    static var users: Self {
        return DummyEndPoint(path: "data/v1/user/", httpMethod: .get, task: .request(query: ["created":"1"]))
    }
    
    static func user(id: String) -> Self {
        
        return DummyEndPoint(path: "data/v1/user/\(id)/", httpMethod: .get, task: .request(query: ["created":"1"]))
    }
    
    static func addUser(result: Result) -> Self {
        
        let bodyData = [
            
            URLQueryItem(name: "title", value: result.name.title.lowercased()),
            URLQueryItem(name: "firstName", value: result.name.first),
            URLQueryItem(name: "lastName", value: result.name.last),
            URLQueryItem(name: "email", value: result.email),
            URLQueryItem(name: "picture", value: result.picture.medium),
            URLQueryItem(name: "gender", value: result.gender),
            URLQueryItem(name: "dateOfBirth", value: result.dob.date),
            URLQueryItem(name: "phone", value: result.phone),
            URLQueryItem(name: "location[street]", value: result.location.street.name),
            URLQueryItem(name: "location[city]", value: result.location.city),
            URLQueryItem(name: "location[state]", value: result.location.state),
            URLQueryItem(name: "location[country]", value: result.location.country),
            URLQueryItem(name: "location[timezone]", value: result.location.timezone.offset)
        ]
        
        return DummyEndPoint(path: "data/v1/user/create", httpMethod: .post, task: .request(body: bodyData, query: ["created":"1"]))
    }
}
