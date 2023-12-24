//
//  MapViewModelType.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 17.12.2023.
//

import Foundation

protocol MapViewModelType: ObservableObject {
    var mapButtonData: [MapButtonData] { get }
    var routesList: [Rout]? { get }
    func checkAuthorization()
    func getRoutesList()
    func getLocations(for rout: Rout)
}
