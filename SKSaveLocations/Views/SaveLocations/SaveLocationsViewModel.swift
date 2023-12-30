//
//  SaveLocationsViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 09.12.2023.
//

import Combine
import CoreLocation
import Foundation

struct LocationData: Codable {
    let timeInterval: Double
    let latitude: Double
    let longitude: Double
}

extension LocationData: Identifiable {
    var id: String {
        return String(timeInterval)
    }
}

final class SaveLocationsViewModel: ObservableObject {
    let locationsStorageService: any LocationsStorageServiceType
    @Published var lastLocation: CLLocation?
    @Published var locations: [LocationData] = []
    private let locationService: any LocationServiceType
    private var locationsName = "Name of location"
    private var cancellables = Set<AnyCancellable>()
    
    init(serviceHolder: ServiceHolderType) {
        self.locationsStorageService = serviceHolder.getLocationsStorageService()
        self.locationService = serviceHolder.getLocationService()
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
        let route = Rout(description: "Rout_\(Date())")
        if let locationsName = locationsStorageService.addRoute(route) {
            self.locationsName = locationsName
            locationService.startUpdatingLocation()
        }
    }
    
    func stopTracking() {
        locationService.stopUpdatingLocation()
    }
}
