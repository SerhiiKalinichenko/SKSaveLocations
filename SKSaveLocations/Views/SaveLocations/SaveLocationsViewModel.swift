//
//  SaveLocationsViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 09.12.2023.
//

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
    let firebaseService: any FirebaseServiceType
    @Published var lastLocation: CLLocation?
    @Published var locations: [LocationData] = []
    private let locationService: LocationService
    private var locationsName = "Name of location"
    
    init(firebaseService: any FirebaseServiceType) {
        self.firebaseService = firebaseService
        self.locationService = LocationService.shared
        //locationService.checkAuthorization()
        locationService.delegate = self
    }
    
    @MainActor func startTracking() {
        let route = Rout(description: "Rout_\(Date())")
        if let locationsName = firebaseService.addRoute(route) {
            self.locationsName = locationsName
            locationService.startUpdatingLocation()
        }
    }
    
    func stopTracking() {
        locationService.stopUpdatingLocation()
    }
}

extension SaveLocationsViewModel: LocationServiceDelegate {
    @MainActor func reportNewLocation(_ location: CLLocation) {
        lastLocation = location
        let newLocation = LocationData(timeInterval: Date().timeIntervalSince1970, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        locations.append(newLocation)
        firebaseService.addLocation(collection: locationsName, location: newLocation)
    }
}
