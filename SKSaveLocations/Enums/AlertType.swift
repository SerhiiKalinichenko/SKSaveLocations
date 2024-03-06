//
//  AlertType.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
//

import SwiftUI

enum AlertType {
    case localized(String, String)
    case error(Error, String)
    
    var message: String {
        switch self {
        case .localized(let string, _):
            return String(localized: String.LocalizationValue(string))
        case .error(let originalError, _):
            return originalError.localizedDescription
        }
    }
    
    var title: String {
        switch self {
        case .localized(_, let title):
            return String(localized: String.LocalizationValue(title))
        case .error(_, let title):
            return String(localized: String.LocalizationValue(title))
        }
    }
}
