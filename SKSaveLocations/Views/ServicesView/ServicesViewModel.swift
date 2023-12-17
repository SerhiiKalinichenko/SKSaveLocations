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
    let firebaseService: any FirebaseServiceType
    private(set) var services: [Service]
    
    init(firebaseService: any FirebaseServiceType) {
        self.firebaseService = firebaseService
        let mapService = Service(type: .map, name: "map" , symbolName: "map.circle")
        let locationService = Service(type: .saveLocation, name: "saveLocation" , symbolName: "map.circle")
        services = [mapService, locationService]
    }
}
