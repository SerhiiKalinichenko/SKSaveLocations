//
//  FirebaseService.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 03.12.2023.
//

import Combine
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import Foundation

@MainActor
protocol FirebaseServiceType: ObservableObject {
    var sessionUser: UserInfo? { get }
    var user: CurrentValueSubject<User?, Never> { get }
    func createUser(email: String, password: String, name: String, phoneNumber: String?, image: UIImage?) async throws
    func changeUsersAvatar(_ image: UIImage?) async
    func logIn(email: String, password: String) async throws
    func logOut()
    func deleteAccount()
    func addLocation(collection: String, location: LocationData)
    func getRoutsList() async throws -> [Rout]?
    func addRoute(_ rout: Rout) -> String?
}

final class FirebaseService: FirebaseServiceType {
    @Published var sessionUser: UserInfo?
    private(set) var user = CurrentValueSubject<User?, Never>(nil)
    private let usersCollection = "users"
    private let avatarsCollection = "avatars"
    private let locationsCollection = "locations"
    private let routesCollection = "routes"
    
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
    
    func changeUsersAvatar(_ image: UIImage?) async {
        guard let usersUid = sessionUser?.uid else {
            return
        }
        do {
            let _ = await setAvatarImage(image, for: usersUid)
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
            user.value = nil
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
        user.value = try? snapshot.data(as: User.self)
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

extension FirebaseService {
    func addLocation(collection: String, location: LocationData) {
        guard let usersUid = sessionUser?.uid else {
            return
        }
        do {
            let userLocationsRef = Firestore.firestore().collection(locationsCollection).document(usersUid)
            try userLocationsRef.collection(collection).document().setData(from: location)
        }
        catch {
            debugPrint("\(error.localizedDescription)")
        }
    }
    
    func addRoute(_ rout: Rout) -> String? {
        guard let usersUid = sessionUser?.uid else {
            return nil
        }
        let routeRef = Firestore.firestore().collection(routesCollection).document(usersUid).collection(routesCollection).document()
        let docId = routeRef.documentID
        var routWithId = rout
        routWithId.id = docId
        saveRoute(routWithId, ref: routeRef)
        return docId
    }
    
    private func saveRoute(_ rout: Rout, ref: DocumentReference) {
        Task {
            try ref.setData(from: rout)
        }
    }
    
    func getRoutsList() async throws -> [Rout]? {
        guard let usersUid = sessionUser?.uid else {
            return nil
        }
        let routeRef = Firestore.firestore().collection(routesCollection).document(usersUid).collection(routesCollection)
        let response = try await routeRef.getDocuments()
        let routes: [Rout] = response.documents.compactMap {
              return try? $0.data(as: Rout.self)
        }
        return routes
    }
}
