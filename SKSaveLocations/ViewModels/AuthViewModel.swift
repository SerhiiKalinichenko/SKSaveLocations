//
//  AuthViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 03.12.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
protocol AuthViewModelType {
    var user: User? { get }
    func createUser(email: String, password: String, name: String) async throws
    func logIn(email: String, password: String) async throws
    func logOut()
    func deleteAccount()
}

final class AuthViewModel: AuthViewModelType, ObservableObject {
    @Published var sessionUser: FirebaseAuth.User?
    @Published var user: User?
    private let usersCollection = "users"
    
    init() {
        self.sessionUser = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }
    
    func createUser(email: String, password: String, name: String) async throws {
        debugPrint("\(email), \(password), \(name)")
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            sessionUser = result.user
            let user = User(id: result.user.uid, email: email, name: name)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection(usersCollection).document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            debugPrint("\(error.localizedDescription)")
        }
    }
    
    func logIn(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            sessionUser = result.user
            await fetchUser()
        } catch {
            debugPrint("\(error.localizedDescription)")
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            sessionUser = nil
            user = nil
        } catch {
            debugPrint("\(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
    }

    private func fetchUser() async {
        guard let userUid = Auth.auth().currentUser?.uid, let snapshot = try? await Firestore.firestore().collection(usersCollection).document(userUid).getDocument() else {
            return
        }
        user = try? snapshot.data(as: User.self)
    }
}
