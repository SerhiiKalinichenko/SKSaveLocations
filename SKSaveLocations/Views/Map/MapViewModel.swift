//
//  MapViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 06.12.2023.
//

import CoreLocation

final class MapViewModel: ObservableObject {
    let locationService: LocationService
    let firebaseService: any FirebaseServiceType
    @Published var routesList: [Rout]?

    init(firebaseService: any FirebaseServiceType) {
        self.firebaseService = firebaseService
        locationService = LocationService.shared
    }
    
    func checkAuthorization() {
        locationService.checkAuthorization()
    }
    
    func getRoutesList() {
        Task {
            routesList = try await firebaseService.getRoutsList()
        }
    }
}
