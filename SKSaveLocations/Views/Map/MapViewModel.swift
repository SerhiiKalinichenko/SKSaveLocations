//
//  MapViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
//

import MapKit
import SwiftUI

final class MapViewModel: MapViewModelType {
    @Published var position: MapCameraPosition = .automatic
    @Published private(set) var observedUsers: [User]?
    @Published private(set) var routesList: [Rout]?
    @Published private(set) var routeLocations: [LocationData]?
    @Published private(set) var observedLocation: CLLocationCoordinate2D?
    private(set) var observedUser: User?
    private(set) var mapButtonData = [MapButtonData]()
    private let locationsStorageService: any LocationsStorageServiceType
    private let userService: any UserServiceType
    private weak var timer: Timer?

    init(serviceHolder: ServiceHolderType) {
        self.userService = serviceHolder.getUserService()
        self.locationsStorageService = serviceHolder.getLocationsStorageService()
        setMapButtonsData()
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
    func getObservedUsersList() {
        Task {
            let users = await userService.fetchUsers()
            observedUsers = users?.filter { $0.activeRout != nil }
        }
    }
    
    func observeUser(_ user: User) {
        stopTimer()
        if observedUser == nil {
            observedUser = user
            Task {
                let uiImage = await ImageLoader.loadImage(url: user.avatarURL)
                if let imageData = uiImage?.pngData() {
                    var user = user
                    user.imageString = imageData.base64EncodedString()
                    observedUser = user
                }
            }
        }
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            guard let self else {
                return
            }
            Task { @MainActor in
                let locations = try await self.locationsStorageService.getRoutLocations(for: user)
                if let lastLocation = locations?.last {
                    self.observedLocation = CLLocationCoordinate2D(latitude: lastLocation.latitude, longitude: lastLocation.longitude)
                }
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        observedUser = nil
    }
    
    private func setMapButtonsData() {
        let routsButton = MapButtonData(type: .routes, name: "routes", image: Image(systemName: "map.circle"))
        let observedUsersButton = MapButtonData(type: .observedUsers, name: "observed.users", image: Image(systemName: "figure.wave"))
        mapButtonData = [routsButton, observedUsersButton]
    }
}
