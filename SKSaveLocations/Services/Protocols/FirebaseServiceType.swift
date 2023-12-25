//
//  FirebaseServiceType.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 25.12.2023.
//

import Combine
import UIKit

protocol FirebaseServiceType: Service, ObservableObject {
    var user: CurrentValueSubject<User?, Never> { get }
    func createUser(email: String, password: String, name: String, phoneNumber: String?, image: UIImage?) async throws
    func changeUsersAvatar(_ image: UIImage?) async
    func logIn(email: String, password: String) async throws
    func logOut()
    func deleteAccount()
    func addLocation(collection: String, location: LocationData)
    func getRoutsList() async throws -> [Rout]?
    func addRoute(_ rout: Rout) -> String?
    func getRoutLocations(_ rout: Rout) async throws -> [LocationData]?
}
