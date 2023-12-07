//
//  MapViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 06.12.2023.
//

import CoreLocation

final class MapViewModel: ObservableObject {
    let locationService: LocationService

    init() {
        locationService = LocationService()
    }
    
    func checkAuthorization() {
        locationService.checkAuthorization()
    }
}
