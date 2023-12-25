//
//  ServicesViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 05.12.2023.
//

import Foundation

enum ServiceType {
    case map
    case saveLocation
}

final class ServicesViewModel: ObservableObject {
    private(set) var services: [Сhapter]
    
    init() {
        let mapService = Сhapter(type: .map, name: "map" , symbolName: "map.circle")
        let locationService = Сhapter(type: .saveLocation, name: "saveLocation" , symbolName: "map.circle")
        services = [mapService, locationService]
    }
}
