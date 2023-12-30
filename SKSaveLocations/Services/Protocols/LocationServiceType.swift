//
//  LocationServiceType.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.12.2023.
//

import Combine
import CoreLocation

protocol LocationServiceType: Service {
    var currentLocation: CurrentValueSubject<CLLocation?, Never> { get }
    func checkAuthorization()
    func startUpdatingLocation()
    func stopUpdatingLocation()
}
