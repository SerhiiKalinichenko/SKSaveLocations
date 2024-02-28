//
//  LocationService.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 06.12.2023.
//

import Combine
import CoreLocation

final class LocationService: NSObject, LocationServiceType {
    
    private(set) var currentLocation = CurrentValueSubject<CLLocation?, Never>(nil)
        
    private let locationManager = CLLocationManager()
    private let desiredAccuracyAndFilter = 15.0
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.showsBackgroundLocationIndicator = true
    }
    
    func checkAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            return
        }
    }
    
    func startUpdatingLocation() {
        locationManager.distanceFilter = desiredAccuracyAndFilter
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = false
        locationManager.distanceFilter = kCLDistanceFilterNone
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation.value = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        switch status {
        case .notDetermined:
            debugPrint("option - not determined")
        case .restricted:
            debugPrint("option - restricted")
        case .denied:
            debugPrint("option - dont't allow")
        case .authorizedAlways:
            debugPrint("option - allow always")
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
        default:
            debugPrint("Default")
        }
    }
}
