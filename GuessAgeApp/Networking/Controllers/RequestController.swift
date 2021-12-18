//
//  RequestController.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 02/12/2021.
//

import Foundation

import Combine

protocol RequestControllerProtocol {
    
    func execute<T>(type: T.Type, _ endpoint: Endpoint) -> AnyPublisher<T, CustomError> where T: Decodable
    
}


final class RequestController {
    
    private func makeRequest(with endpoint: Endpoint) throws -> URLRequest {
        guard let url = endpoint.url else {
            throw CustomError(status: .invalidURL)
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = endpoint.httpMethod.rawValue
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        endpoint.headers?.forEach({
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        })
        
        switch endpoint.task {
        case .request(let body, let query):
            
            if let query = query {
                
                request.url = try queryUrl(for: request, with: query)
                
            }
            
            if let body = body {
                
                // request.httpBody = try data(for: body)
                var requestBodyComponents = URLComponents()
                requestBodyComponents.queryItems = body
                request.httpBody = requestBodyComponents.query?.data(using: .utf8)
                
            }
        }
        
        
        return request
        
    }
    
    private func queryUrl( for request: URLRequest, with query: QueryParameters ) throws -> URL {
        
        guard let url = request.url, var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            
            throw CustomError(status: .invalidURL)
            
        }
        
        components.queryItems = query.map({ item in
            let name = item.key
            let value = item.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            return URLQueryItem(name: name, value: value)
        })
        
        guard let updatedUrl = components.url else {
            
            throw CustomError(status: .invalidParameters)
            
        }
        
        return updatedUrl
        
    }
    
    
    private func data(for body: BodyParameters) throws -> Data {
        do {
            
            return try JSONSerialization.data(withJSONObject: body)
            
        } catch {
            
            throw CustomError(status: .invalidParameters)
            
        }
    }
    
    /*private func urlEncodedBody(for body: BodyParameters) -> [URLQueryItem] {
        
        let queryItem = body.map { item -> URLQueryItem in
            let name = item.key
            let value = item.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            return URLQueryItem(name: name, value: value)
        }
        
        return queryItem
    }*/
  
}


extension RequestController: RequestControllerProtocol {
  
    func execute<T>(type: T.Type, _ endpoint: Endpoint) -> AnyPublisher<T, CustomError> where T: Decodable {
        
        do {
            
            let request = try makeRequest(with: endpoint)
            
            return URLSession
                .shared
                .dataTaskPublisher(for: request)
                .tryMap { result -> Data in
                    guard let response = result.response as? HTTPURLResponse else {
                        
                        throw CustomError(status: .unableToDecode)
                        
                    }
                    
                    if !(200...299).contains(response.statusCode) {
                        if let error = try? JSONDecoder().decode(CustomError.self, from: result.data) {
                            
                            throw error
                            
                        }
                        
                        throw CustomError(statusCode: response.statusCode)
                        
                    }
                    
                    return result.data
                    
                }
                .tryMap { data in
                    do {
                        let value = try JSONDecoder().decode(T.self, from: data)
                        return value
                    } catch {
                        
                        throw CustomError(status: .unableToDecode)
                    }
                }
                .mapError({ error in
                    return CustomError.convert(error: error)
                })
                .eraseToAnyPublisher()
            
        } catch let error {
            
            return Fail(error: CustomError.convert(error: error)).eraseToAnyPublisher()
            
        }
  }
  
}
