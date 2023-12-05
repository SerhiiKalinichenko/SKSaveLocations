//
//  MainTabViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 05.12.2023.
//

import SwiftUI

@MainActor
final class MainTabViewModel: ObservableObject {
    let authService: any AuthServiceType

    var profileVM: ProfileViewModel {
        return ProfileViewModel(authService: authService)
    }
    
    var servicesVM: ServicesViewModel {
        return ServicesViewModel()
    }

    init(authService: any AuthServiceType) {
        self.authService = authService
    }
}
