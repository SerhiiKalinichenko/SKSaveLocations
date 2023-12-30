//
//  LocationServiceMock.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 31.12.2023.
//

import Combine
import CoreLocation
import Foundation

final class LocationServiceMock: LocationServiceType {
    var currentLocation = CurrentValueSubject<CLLocation?, Never>(nil)
    
    func checkAuthorization() {
    }
    
    func startUpdatingLocation() {
    }
    
    func stopUpdatingLocation() {
    }
}
