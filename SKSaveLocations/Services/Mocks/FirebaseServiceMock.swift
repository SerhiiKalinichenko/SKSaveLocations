//
//  FirebaseServiceMock.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 04.12.2023.
//

import Combine
import Foundation
import Firebase
import FirebaseFirestoreSwift

final class FirebaseServiceMock: FirebaseServiceType {
    @Published var sessionUser: UserInfo?
    private(set) var user = CurrentValueSubject<User?, Never>(nil)
    
    init() {
        self.sessionUser = AuthUserMock(uid: "12345")
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

    private func fetchUser() async {
    }
    
    func addLocation(collection: String, location: LocationData) {
    }
    
    func getRoutsList() async throws -> [Rout]? {
        return nil
    }
    
    func addRoute(_ rout: Rout) -> String? {
        return nil
    }
    
    func getRoutLocations(_ rout: Rout) async throws -> [LocationData]? {
        return nil
    }
}
