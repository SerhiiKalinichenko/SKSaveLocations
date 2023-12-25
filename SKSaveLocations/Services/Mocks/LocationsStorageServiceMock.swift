//
//  LocationsStorageServiceMock.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 25.12.2023.
//

import Foundation

final class LocationsStorageServiceMock: LocationsStorageServiceType {
    func addLocation(collection: String, location: LocationData) {
    }
    
    func getRoutsList() async throws -> [Rout]? {
        return nil
    }
    
    func addRoute(_ rout: Rout) -> String? {
        return nil
    }
    
    func getRoutLocations(_ rout: Rout) async throws -> [LocationData]? {
        return nil
    }
}
