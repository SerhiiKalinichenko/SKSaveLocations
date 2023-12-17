//
//  LocationService.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 06.12.2023.
//

import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func reportNewLocation(_ location: CLLocation)
}

final class LocationService: NSObject {
    
    static let shared = LocationService()
    
    weak var delegate: LocationServiceDelegate?
    
    var currentLocation: CLLocation {
        get async throws {
            return try await withCheckedThrowingContinuation { continuation in
                self.continuation = continuation
                locationManager.requestLocation()
            }
        }
    }
    
    private let locationManager = CLLocationManager()
    private let desiredAccuracyAndFilter = 15.0
    private var continuation: CheckedContinuation<CLLocation, Error>?
    
    private override init() {
        super.init()
        locationManager.delegate = self
        //locationManager.distanceFilter = desiredAccuracyAndFilter
        locationManager.distanceFilter = kCLDistanceFilterNone
        //desiredAccuracy
        //kCLLocationAccuracyBestForNavigation
        //locationManager.pausesLocationUpdatesAutomatically = false
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
        locationManager.allowsBackgroundLocationUpdates = true
        // TODO: set it propertly
        //locationManager.showsBackgroundLocationIndicator = true
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.stopUpdatingLocation()
    }
    
//    private func requestOnTimeLocation() {
//        locationManager.requestLocation()
//    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            continuation?.resume(returning: location)
            continuation = nil
            delegate?.reportNewLocation(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.resume(throwing: error)
        continuation = nil
        if let error = error as? CLError, error.code == .denied {
            //manager.stopUpdatingLocation()
        }
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        switch status {
        case .notDetermined:
            debugPrint("option - not determined")
            //locationManager.requestWhenInUseAuthorization()
        case .restricted:
            debugPrint("option - restricted")
        case .denied:
            debugPrint("option - dont't allow")
            // 1
        case .authorizedAlways:
            debugPrint("option - allow always")
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
        default:
            debugPrint("Default")
        }
    }
}
