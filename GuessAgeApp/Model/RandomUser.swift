//
//  RandomUser.swift
//  GuessAgeApp
//
//  Created by Umoru Joseph on 25/11/2021.
//

import Foundation

// MARK: - RandomUser
struct RandomUser: Codable, CustomStringConvertible {
    var results: [Result]?
    var info: Info?
}

// MARK: - Info
struct Info: Codable, CustomStringConvertible {
    var seed: String?
    var results, page: Int?
    var version: String?
}

// MARK: - Result
struct Result: Codable, CustomStringConvertible {
    var gender: String?
    var name: Name?
    var location: Location?
    var email: String?
    var login: Login?
    var dob, registered: Dob?
    var phone, cell: String?
    var id: ID?
    var picture: Picture?
    var nat: String?
}

// MARK: - Dob
struct Dob: Codable, CustomStringConvertible {
    var date: String?
    var age: Int?
}

// MARK: - ID
struct ID: Codable, CustomStringConvertible {
    var name: String?
    var value: JSONNull?
}

// MARK: - Location
struct Location: Codable, CustomStringConvertible {
    var street: Street?
    var city, state, country, postcode: String?
    var coordinates: Coordinates?
    var timezone: Timezone?
}

// MARK: - Coordinates
struct Coordinates: Codable, CustomStringConvertible {
    var latitude, longitude: String?
}

// MARK: - Street
struct Street: Codable, CustomStringConvertible {
    var number: Int?
    var name: String?
}

// MARK: - Timezone
struct Timezone: Codable, CustomStringConvertible {
    var offset, timezoneDescription: String?

    enum CodingKeys: String, CodingKey {
        case offset
        case timezoneDescription = "description"
    }
}

// MARK: - Login
struct Login: Codable, CustomStringConvertible {
    var uuid, username, password, salt: String?
    var md5, sha1, sha256: String?
}

// MARK: - Name
struct Name: Codable, CustomStringConvertible {
    var title, first, last: String?
}

// MARK: - Picture
struct Picture: Codable, CustomStringConvertible {
    var large, medium, thumbnail: String?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
