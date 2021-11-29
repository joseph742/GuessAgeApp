
import Foundation

// MARK: - RandomUser
struct RandomUser: Codable, CustomStringConvertible {
    var results: [Result]
}

// MARK: - Result
struct Result: Codable, CustomStringConvertible {
    var gender: String
    var name: Name
    var location: Location
    var email: String
    var dob, registered: Dob
    var phone, cell: String
    // var id: ID
    var picture: Picture
}

// MARK: - Dob
struct Dob: Codable, CustomStringConvertible {
    var date: String
    var age: Int
}

// MARK: - Location
struct Location: Codable, CustomStringConvertible {
    var city, state, country: String
    var postcode: Int
    var coordinates: Coordinates
    var timezone: Timezone
}

// MARK: - Coordinates
struct Coordinates: Codable, CustomStringConvertible {
    var latitude, longitude: String
}

// MARK: - Timezone
struct Timezone: Codable, CustomStringConvertible {
    var offset, timezoneDescription: String

    enum CodingKeys: String, CodingKey {
        case offset
        case timezoneDescription = "description"
    }
}

// MARK: - Name
struct Name: Codable, CustomStringConvertible {
    var title, first, last: String
}

// MARK: - Picture
struct Picture: Codable, CustomStringConvertible {
    var large, medium, thumbnail: String
}
