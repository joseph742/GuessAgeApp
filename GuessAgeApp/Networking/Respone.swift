//
//  Respone.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 26/11/2021.
//

import Foundation

struct Response<T> {
    let value: T
    let response: URLResponse
}
