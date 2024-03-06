//
//  MainTabViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
//

import SwiftUI

final class MainTabViewModel: ObservableObject {

    var profileVM: ProfileViewModel {
        return ProfileViewModel(serviceHolder: ServiceHolder.shared)
    }
    
    var servicesVM: ServicesViewModel {
        return ServicesViewModel(serviceHolder: ServiceHolder.shared)
    }
}
