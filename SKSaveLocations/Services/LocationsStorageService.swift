//
//  LocationsStorageService.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 25.12.2023.
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import Foundation

final class LocationsStorageService: LocationsStorageServiceType {
    
    private let locationsCollection = "locations"
    private let routesCollection = "routes"
    
    private var userId: String? {
        UserSession.shared.user?.id
    }
    
    func addLocation(collection: String, location: LocationData) {
        guard let userId else {
            return
        }
        do {
            let userLocationsRef = Firestore.firestore().collection(locationsCollection).document(userId)
            try userLocationsRef.collection(collection).document().setData(from: location)
        }
        catch {
            debugPrint("\(error.localizedDescription)")
        }
    }
    
    func addRoute(_ rout: Rout) -> String? {
        guard let userId else {
            return nil
        }
        let routeRef = Firestore.firestore().collection(routesCollection).document(userId).collection(routesCollection).document()
        let docId = routeRef.documentID
        var routWithId = rout
        routWithId.id = docId
        saveRoute(routWithId, ref: routeRef)
        return docId
    }
        
    func getRoutsList() async throws -> [Rout]? {
        guard let userId else {
            return nil
        }
        let routeRef = Firestore.firestore().collection(routesCollection).document(userId).collection(routesCollection)
        let response = try await routeRef.getDocuments()
        let routes: [Rout] = response.documents.compactMap {
              return try? $0.data(as: Rout.self)
        }
        return routes
    }
    
    func getRoutLocations(_ rout: Rout) async throws -> [LocationData]? {
        guard let userId else {
            return nil
        }
        let locationsRef = Firestore.firestore().collection(locationsCollection).document(userId).collection(rout.id)
        let response = try await locationsRef.getDocuments()
        let locations: [LocationData] = response.documents.compactMap {
              return try? $0.data(as: LocationData.self)
        }
        return locations
    }
    
    func getRoutLocations(for user: User) async throws -> [LocationData]? {
        guard let routId = user.activeRout else {
            return nil
        }
        let locationsRef = Firestore.firestore().collection(locationsCollection).document(user.id).collection(routId)
        let response = try await locationsRef.getDocuments()
        let locations: [LocationData] = response.documents.compactMap {
              return try? $0.data(as: LocationData.self)
        }
        return locations.sorted { $0.timeInterval < $1.timeInterval }
    }
    
    private func saveRoute(_ rout: Rout, ref: DocumentReference) {
        Task {
            try ref.setData(from: rout)
        }
    }
}
