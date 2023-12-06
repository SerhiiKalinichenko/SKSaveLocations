//
//  ProfileViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 04.12.2023.
//

import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    let authService: any AuthServiceType

    init(authService: any AuthServiceType) {
        self.authService = authService
    }
    
    func logOut() {
        authService.logOut()
    }
    
    func deleteAccount() {
        authService.deleteAccount()
    }
}
