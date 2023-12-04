//
//  String.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 04.12.2023.
//

import Foundation

extension String {
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: self) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}
