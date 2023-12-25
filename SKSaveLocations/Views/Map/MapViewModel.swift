//
//  MapViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 06.12.2023.
//

import SwiftUI

final class MapViewModel: MapViewModelType {
    let locationService: LocationService
    let locationsStorageService: any LocationsStorageServiceType
    let userService: any UserServiceType
    @Published var routesList: [Rout]?
    @Published var routeLocations: [LocationData]?
    var mapButtonData = [MapButtonData]()

    init(serviceHolder: ServiceHolderType) {
        self.userService = serviceHolder.getUserService()
        self.locationsStorageService = serviceHolder.getLocationsStorageService()
        locationService = LocationService.shared
        setMapButtonsData()
    }
    
    func checkAuthorization() {
        locationService.checkAuthorization()
    }
    
    @MainActor
    func getRoutesList() {
        Task {
            routesList = try await locationsStorageService.getRoutsList()
        }
    }
    
    @MainActor
    func getLocations(for rout: Rout) {
        Task {
            routeLocations = try await locationsStorageService.getRoutLocations(rout)
        }
    }
    
    private func setMapButtonsData() {
        let routsButton = MapButtonData(type: .routes, name: "routes", image: Image(systemName: "map.circle"))
        mapButtonData = [routsButton]
    }
}
