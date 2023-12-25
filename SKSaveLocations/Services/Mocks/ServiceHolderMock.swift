//
//  ServiceHolderMock.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 25.12.2023.
//

import Foundation

final class ServiceHolderMock: ServiceHolderType {
    func getFBService() -> any FirebaseServiceType {
        return FirebaseServiceMock()
    }
}
