//
//  MapViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 06.12.2023.
//

import MapKit
import SwiftUI

final class MapViewModel: MapViewModelType {
    @Published var position: MapCameraPosition = .automatic
    @Published var routesList: [Rout]?
    @Published var routeLocations: [LocationData]?
    var mapButtonData = [MapButtonData]()
    private let locationService: any LocationServiceType
    private let locationsStorageService: any LocationsStorageServiceType
    private let userService: any UserServiceType

    init(serviceHolder: ServiceHolderType) {
        self.userService = serviceHolder.getUserService()
        self.locationsStorageService = serviceHolder.getLocationsStorageService()
        self.locationService = serviceHolder.getLocationService()
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
            let locations = try await locationsStorageService.getRoutLocations(rout)
            routeLocations = locations?.sorted { $0.timeInterval < $1.timeInterval }
        }
    }
    
    @MainActor
    func getUsersList() {
        Task {
            let users = await userService.fetchUsers()
        }
    }
    
    private func setMapButtonsData() {
        let routsButton = MapButtonData(type: .routes, name: "routes", image: Image(systemName: "map.circle"))
        mapButtonData = [routsButton]
    }
}
