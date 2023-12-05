//
//  ServicesViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 05.12.2023.
//

import Foundation

final class ServicesViewModel: ObservableObject {
    private(set) var services: [Service]
    
    init() {
        let mapService = Service(name: "map", symbolName: "map.circle")
        services = [mapService]
    }
}
