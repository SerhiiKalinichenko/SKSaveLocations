//
//  ServiceHolderType.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 25.12.2023.
//

import Foundation

protocol ServiceHolderType {
    //func getUserService() -> any UserServiceType
    func getFBService() -> any FirebaseServiceType
}
