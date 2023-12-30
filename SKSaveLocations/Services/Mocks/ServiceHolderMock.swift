//
//  ServiceHolderMock.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 25.12.2023.
//

import Foundation

final class ServiceHolderMock: ServiceHolderType {
    func getLocationService() -> any LocationServiceType {
        return LocationServiceMock()
    }
    
    func getLocationsStorageService() -> any LocationsStorageServiceType {
        return LocationsStorageServiceMock()
    }
    
    func getUserService() -> any UserServiceType {
        return UserServiceMock()
    }
}
