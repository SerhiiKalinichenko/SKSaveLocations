//
//  UserServiceMock.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 04.12.2023.
//

import Combine
import UIKit

final class UserServiceMock: UserServiceType {
    private(set) var user = CurrentValueSubject<User?, Never>(nil)
    
    init() {
        self.user.value = User(id: "12345", email: "test@test.com", name: "John Smith", phoneNumber: "123456789", photoURL: nil)
    }
    
    func createUser(email: String, password: String, name: String, phoneNumber: String?, image: UIImage?) async throws {
    }
    
    func changeUsersAvatar(_ image: UIImage?) async {
    }
    
    func logIn(email: String, password: String) async throws {
    }
    
    func logOut() {
    }
    
    func deleteAccount() {
    }
}
