//
//  ServiceHolder.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 25.12.2023.
//

import Foundation

final class ServiceHolder {
    
    static var shared = ServiceHolder()
    private var services = [String: Service]()
    
    private init() {
        initServices()
    }
    
    private func initServices() {
        add((any FirebaseServiceType).self, for: FirebaseService())
    }
    
    func add<T>(_ type: T.Type, for instance: Service) {
        let serviceName = String(reflecting: type)
        services[serviceName] = instance
    }
    
    func get<T>(by type: T.Type = T.self) -> T {
        return get(by: String(reflecting: type))
    }

    func remove<T>(by type: T.Type) {
        let serviceName = String(reflecting: type)
        if services[serviceName] as? T != nil {
            services[serviceName] = nil
        }
    }
    
    private func get<T>(by name: String) -> T {
        guard let service = services[name] as? T else {
            fatalError("Firstly you have to add service \(name)")
        }
        return service
    }
}

extension ServiceHolder: ServiceHolderType {
    func getFBService() -> any FirebaseServiceType {
        return get(by: (any FirebaseServiceType).self)
    }
}
