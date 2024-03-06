//
//  User.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let email: String
    let name: String
    let phoneNumber: String?
    let photoURL: String?
    var activeRout: String?
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
