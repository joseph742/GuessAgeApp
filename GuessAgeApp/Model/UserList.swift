//
//  UserList.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 25/11/2021.
//

import Foundation

// MARK: - UserList
struct UserList: Codable, CustomStringConvertible {
    var data: [Datum]
    var total, page, limit: Int
}

// MARK: - Datum
struct Datum: Codable, CustomStringConvertible, Identifiable {
    var id: String
    var title: Title
    var firstName, lastName: String
    var picture: String
}

enum Title: String, Codable {
    case miss = "miss"
    case mr = "mr"
    case mrs = "mrs"
    case ms = "ms"
}
