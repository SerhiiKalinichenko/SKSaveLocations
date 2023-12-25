//
//  MainTabViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 05.12.2023.
//

import SwiftUI

@MainActor
final class MainTabViewModel: ObservableObject {
    let firebaseService: any FirebaseServiceType

    var profileVM: ProfileViewModel {
        return ProfileViewModel(firebaseService: firebaseService)
    }
    
    var servicesVM: ServicesViewModel {
        return ServicesViewModel(firebaseService: firebaseService)
    }

    init(serviceHolder: ServiceHolderType) {
        self.firebaseService = serviceHolder.getFBService()
    }
}
