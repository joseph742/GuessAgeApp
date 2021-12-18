//
//  Endpoint.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 02/12/2021.
//

import Foundation

public protocol Endpoint {
    
    var host: String { get }
    var path: String { get }
    var url: URL? { get }
    var headers: HTTPHeaders? { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }

}
 
extension Endpoint {
    
    public var host: String { DummyAPIConfig.host }
    
    public var url: URL? { URL(string: "\(host)\(path)") }
    
    public var headers: HTTPHeaders? { nil }
 
}
