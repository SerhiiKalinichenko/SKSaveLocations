//
//  User.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 03.12.2023.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let email: String
    let name: String
}

extension User {
    var avatarText: String {
        name.initials
    }
}
