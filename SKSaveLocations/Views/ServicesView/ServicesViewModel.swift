//
//  ServicesViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
//

import Foundation

enum ServiceType {
    case map
    case saveLocation
}

final class ServicesViewModel: ObservableObject {
    private let locationService: any LocationServiceType
    private(set) var services: [Сhapter]
    
    init(serviceHolder: ServiceHolderType) {
        self.locationService = serviceHolder.getLocationService()
        let mapService = Сhapter(type: .map, name: "map" , symbolName: "map.circle")
        let locationService = Сhapter(type: .saveLocation, name: "saveLocation" , symbolName: "map.circle")
        services = [mapService, locationService]
    }
    
    func checkAuthorization() {
        locationService.checkAuthorization()
    }
}
