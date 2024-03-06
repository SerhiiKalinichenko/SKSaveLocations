//
//  MapViewModelType.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
//

import Foundation

protocol MapViewModelType: ObservableObject {
    var mapButtonData: [MapButtonData] { get }
    var routesList: [Rout]? { get }
    func getObservedUsersList()
    func getLocations(for rout: Rout)
    func getRoutesList()
}
