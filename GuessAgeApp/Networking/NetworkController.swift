//
//  NetworkController.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 25/11/2021.
//

import Foundation
import Combine
import UIKit

protocol NetworkControllerProtocol: AnyObject {
    typealias Headers = [String: Any]
    typealias Body = [URLQueryItem]
    
    func request<T>(type: T.Type, components: URLComponents, headers: Headers) -> AnyPublisher<T, APIError> where T: Decodable
    
    func post<T>(type: T.Type, components: URLComponents, headers: Headers, body: Body) -> AnyPublisher<T, APIError> where T: Decodable
}


class NetworkController: NetworkControllerProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
      self.session = session
    }
    
    func request<T>(type: T.Type, components: URLComponents, headers: Headers) -> AnyPublisher<T, APIError> where T : Decodable {
        guard let url = components.url else {
            return Fail(error: APIError.badURL).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        
        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        /*return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { result -> Response<T>  in
                let value = try JSONDecoder().decode(T.self, from: result.data)
                  return Response(value: value, response: result.response)
            }
            .mapError({ error -> APIError in
            .ParsingError
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()*/
        
        /*return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { result -> Response<T> in
                do {
                    let value = try JSONDecoder().decode(T.self, from: result.data)
                    return Response(value: value, response: result.response)
                } catch {
                    throw APIError.ParsingError
                }
            }
            .tryMap { response in
                guard let httpResponse = response.response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    switch (response.response as! HTTPURLResponse).statusCode {
                        case (400...499):
                        throw APIError.HTTPError(statusCode: (response.response as! HTTPURLResponse).statusCode)
                        default:
                        throw APIError.ServerError(message: (response.response as! HTTPURLResponse).description)
                        }
                }
                
                return response.value
            }
            .mapError { $0 as! APIError }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()*/
        
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { error in
                APIError.convert(error: error)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
    
    func post<T>(type: T.Type, components: URLComponents, headers: Headers, body: Body) -> AnyPublisher<T, APIError> where T : Decodable {
        guard let url = components.url else {
            return Fail(error: APIError.badURL).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        
        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        var requestBodyComponents = URLComponents()
        requestBodyComponents.queryItems = body
        
        urlRequest.httpBody = requestBodyComponents.query?.data(using: .utf8)
        
        
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { error in
                APIError.convert(error: error)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
    
}
