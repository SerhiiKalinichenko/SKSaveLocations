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
    let phoneNumber: String?
    let photoURL: String?
}

extension User {
    var avatarText: String {
        name.initials
    }
    
    var avatarURL: URL? {
        if let photoURL {
            return URL(string: photoURL)
        }
        return nil
    }
}
