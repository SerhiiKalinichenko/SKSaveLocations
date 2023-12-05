//
//  Service.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 05.12.2023.
//

import SwiftUI

struct Service: Identifiable {
    let id = UUID()
    let name: LocalizedStringKey
    let symbolName: String?
}

extension Service {
    var image: Image? {
        if let symbolName {
            return Image(systemName: symbolName)
        }
        return nil
    }
}
