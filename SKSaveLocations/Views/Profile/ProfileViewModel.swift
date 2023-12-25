//
//  ProfileViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 04.12.2023.
//

import Combine
import SwiftUI

final class ProfileViewModel: ObservableObject {
    @Published private(set) var currentUser: User?
    let firebaseService: any FirebaseServiceType
    private var cancellables = Set<AnyCancellable>()

    init(firebaseService: any FirebaseServiceType) {
        self.firebaseService = firebaseService
        firebaseService.user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.currentUser = user
            }.store(in: &cancellables)
    }
    
    func logOut() {
        firebaseService.logOut()
    }
    
    func deleteAccount() {
        firebaseService.deleteAccount()
    }
    
    func changeUsersAvatar(_ image: UIImage?) {
        Task {
            await firebaseService.changeUsersAvatar(image)
        }
    }
}
