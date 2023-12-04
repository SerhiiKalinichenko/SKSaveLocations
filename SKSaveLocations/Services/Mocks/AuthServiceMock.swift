//
//  AuthServiceMock.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 04.12.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

final class AuthServiceMock: AuthServiceType {
    @Published var sessionUser: UserInfo?
    @Published var user: User?
    
    init() {
        self.sessionUser = AuthUserMock(uid: "12345")
        self.user = User(id: "12345", email: "test@test.com", name: "John Smith")
    }
    
    func createUser(email: String, password: String, name: String) async throws {
    }
    
    func logIn(email: String, password: String) async throws {
    }
    
    func logOut() {
    }
    
    func deleteAccount() {
    }

    private func fetchUser() async {
    }
}

