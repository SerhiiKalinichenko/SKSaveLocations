//
//  MapButtonData.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
//

import SwiftUI

enum MapButtonType {
    case routes
    case observedUsers
    case other
}

struct MapButtonData: Identifiable {
    let id = UUID()
    let type: MapButtonType
    let name: LocalizedStringKey
    let image: Image?
}
