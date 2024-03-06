//
//  LocationsStorageServiceType.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 25.12.2023.
//

import Foundation

protocol LocationsStorageServiceType: Service {
    func addLocation(collection: String, location: LocationData)
    func getRoutsList() async throws -> [Rout]?
    func addRoute(_ rout: Rout) -> String?
    func getRoutLocations(_ rout: Rout) async throws -> [LocationData]?
    func getRoutLocations(for user: User) async throws -> [LocationData]?
}
