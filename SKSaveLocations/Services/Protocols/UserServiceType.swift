//
//  UserServiceType.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 25.12.2023.
//

import Combine
import UIKit

protocol UserServiceType: Service, ObservableObject {
    var user: CurrentValueSubject<User?, Never> { get }
    func addActiveRout(_ id: String?) async
    func createUser(email: String, password: String, name: String, phoneNumber: String?, image: UIImage?) async throws
    func changeUsersAvatar(_ image: UIImage?) async
    func deleteAccount()
    func fetchUsers() async -> [User]?
    func logIn(email: String, password: String) async throws
    func logOut()
}
