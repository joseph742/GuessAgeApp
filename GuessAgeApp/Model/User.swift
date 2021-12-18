//
//  User.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 25/11/2021.
//

import Foundation

// MARK: - User
struct User: Codable, CustomStringConvertible {
    var id, title, firstName, lastName: String
    var picture: String
    var gender, email, dateOfBirth, phone: String
    var location: UserLocation
    var registerDate, updatedDate: String
}

// MARK: - Location
struct UserLocation: Codable, CustomStringConvertible {
    var street, city, state, country: String
    var timezone: String
}
