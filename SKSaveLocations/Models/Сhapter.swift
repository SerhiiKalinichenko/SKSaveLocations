//
//  Service.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 05.12.2023.
//

import SwiftUI

struct Сhapter: Identifiable {
    let id = UUID()
    let type: ServiceType
    let name: LocalizedStringKey
    let symbolName: String?
}

extension Сhapter: Hashable {
    var image: Image? {
        if let symbolName {
            return Image(systemName: symbolName)
        }
        return nil
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
