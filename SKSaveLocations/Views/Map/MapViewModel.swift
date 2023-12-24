//
//  MapViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 06.12.2023.
//

import SwiftUI

final class MapViewModel: MapViewModelType {
    let locationService: LocationService
    let firebaseService: any FirebaseServiceType
    @Published var routesList: [Rout]?
    @Published var routeLocations: [LocationData]?
    var mapButtonData = [MapButtonData]()

    init(firebaseService: any FirebaseServiceType) {
        self.firebaseService = firebaseService
        locationService = LocationService.shared
        setMapButtonsData()
    }
    
    func checkAuthorization() {
        locationService.checkAuthorization()
    }
    
    @MainActor
    func getRoutesList() {
        Task {
            routesList = try await firebaseService.getRoutsList()
        }
    }
    
    @MainActor
    func getLocations(for rout: Rout) {
        Task {
            routeLocations = try await firebaseService.getRoutLocations(rout)
        }
    }
    
    private func setMapButtonsData() {
        let routsButton = MapButtonData(type: .routes, name: "routes", image: Image(systemName: "map.circle"))
        mapButtonData = [routsButton]
    }
}
