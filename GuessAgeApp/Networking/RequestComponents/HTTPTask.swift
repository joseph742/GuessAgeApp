//
//  HTTPTask.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 02/12/2021.
//

import Foundation

public enum HTTPTask {
    
    case request(body: BodyParameters? = nil, query: QueryParameters? = nil)
    
    // More types of tasks can be added here (i.e. download, file upload, etc...)
}
