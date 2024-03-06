//
//  ProfileViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
//

import Combine
import SwiftUI

final class ProfileViewModel: ObservableObject {
    @Published private(set) var currentUser: User?
    let userService: any UserServiceType
    private var cancellables = Set<AnyCancellable>()

    init(serviceHolder: ServiceHolderType) {
        self.userService = serviceHolder.getUserService()
        userService.user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.currentUser = user
            }.store(in: &cancellables)
    }
    
    func logOut() {
        userService.logOut()
    }
    
    func deleteAccount() {
        userService.deleteAccount()
    }
    
    func changeUsersAvatar(_ image: UIImage?) {
        Task {
            await userService.changeUsersAvatar(image)
        }
    }
}
