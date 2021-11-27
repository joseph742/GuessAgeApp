//
//  CustomStringConvertible+Description.swift
//  GuessAgeApp
//
//  Created by Joseph Umoru on 25/11/2021.
//

import Foundation

extension CustomStringConvertible where Self: Codable {
    var description: String {
        var description = "\n***** \(type(of: self)) *****\n"
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value)\n"
            }
        }
        return description
    }
    
}
