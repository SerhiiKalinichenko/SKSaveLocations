//
//  AuthService.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 03.12.2023.
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import Foundation

@MainActor
protocol AuthServiceType {
    var sessionUser: UserInfo? { get }
    var user: User? { get }
    func createUser(email: String, password: String, name: String, phoneNumber: String?, image: UIImage?) async throws
    func logIn(email: String, password: String) async throws
    func logOut()
    func deleteAccount()
}

final class AuthService: AuthServiceType, ObservableObject {
    @Published var sessionUser: UserInfo?
    @Published var user: User?
    private let usersCollection = "users"
    private let avatarsCollection = "avatars"
    
    init() {
        self.sessionUser = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }
    
    func createUser(email: String, password: String, name: String, phoneNumber: String?, image: UIImage?) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            sessionUser = result.user
            let photoURL = await setAvatarImage(image, for: result.user.uid)
            let user = User(id: result.user.uid, email: email, name: name, phoneNumber: phoneNumber, photoURL: photoURL?.absoluteString)
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
        
    private func setAvatarImage(_ image: UIImage?, for userID: String) async -> URL? {
        guard let image, let data = image.jpegData(compressionQuality: 0.1)  else {
            return nil
        }
        do {
            let url = try await upload(imageData: data, path: "\(avatarsCollection)/\(userID)")
            return url
        } catch {
            debugPrint("\(error.localizedDescription)")
            return nil
        }
    }
    
    private func upload(imageData: Data, path: String) async throws -> URL {
        let imageRef = Storage.storage().reference().child(path)
        let _ = try await imageRef.putDataAsync(imageData)
        let url = try await imageRef.downloadURL()
        return url
    }
}
