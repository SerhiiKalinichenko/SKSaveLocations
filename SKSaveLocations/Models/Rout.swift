//
//  Rout.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 14.12.2023.
//

import Foundation

struct Rout: Codable {
    var id: String = ""
    var begin: Double = Date().timeIntervalSince1970
    var description: String?
    var type: String = "test"
}
