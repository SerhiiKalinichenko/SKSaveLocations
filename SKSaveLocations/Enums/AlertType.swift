//
//  AlertType.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 24.12.2023.
//

import SwiftUI

enum AlertType {
    case localized(String)
    case error(Error)
    
    var message: String {
        switch self {
        case .localized(let string):
            return String(localized: String.LocalizationValue(string))
        case .error(let originalError):
            return originalError.localizedDescription
        }
    }
}
