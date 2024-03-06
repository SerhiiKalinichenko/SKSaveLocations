//
//  SaveLocationsViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
//

import Combine
import CoreLocation
import Foundation

struct LocationData: Codable {
    let timeInterval: Double
    let latitude: Double
    let longitude: Double
}

extension LocationData {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension LocationData: Identifiable {
    var id: String {
        return String(timeInterval)
    }
}

final class SaveLocationsViewModel: ObservableObject {
    @Published private(set) var isTracking = false
    @Published private(set) var lastLocation: CLLocation?
    @Published private(set) var locations: [LocationData] = []
    private let locationsStorageService: any LocationsStorageServiceType
    private let locationService: any LocationServiceType
    private let userService: any UserServiceType
    private var locationsName = "Name of location"
    private var cancellables = Set<AnyCancellable>()
    
    init(serviceHolder: ServiceHolderType) {
        self.locationsStorageService = serviceHolder.getLocationsStorageService()
        self.locationService = serviceHolder.getLocationService()
        self.userService = serviceHolder.getUserService()
        locationService.currentLocation.sink { [weak self] location in
            if let self, let location {
                lastLocation = location
                let newLocation = LocationData(timeInterval: Date().timeIntervalSince1970, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                locations.append(newLocation)
                locationsStorageService.addLocation(collection: locationsName, location: newLocation)
            }
        }.store(in: &cancellables)
    }
    
    @MainActor func startTracking() {
        isTracking = true
        let route = Rout(description: "Rout_\(Date())")
        if let locationsName = locationsStorageService.addRoute(route) {
            self.locationsName = locationsName
            locationService.startUpdatingLocation()
            Task {
                await userService.addActiveRout(locationsName)
            }
        }
    }
    
    func stopTracking() {
        isTracking = false
        locationService.stopUpdatingLocation()
        Task {
            await userService.addActiveRout(nil)
        }
    }
}
