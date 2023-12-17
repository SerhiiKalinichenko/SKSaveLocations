//
//  MapButtonData.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 17.12.2023.
//

import SwiftUI

enum MapButtonType {
    case routes
    case other
}

struct MapButtonData: Identifiable {
    let id = UUID()
    let type: MapButtonType
    let name: LocalizedStringKey
    let image: Image?
}
