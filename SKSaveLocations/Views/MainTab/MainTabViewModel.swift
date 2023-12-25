//
//  MainTabViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 05.12.2023.
//

import SwiftUI

final class MainTabViewModel: ObservableObject {

    var profileVM: ProfileViewModel {
        return ProfileViewModel(serviceHolder: ServiceHolder.shared)
    }
    
    var servicesVM: ServicesViewModel {
        return ServicesViewModel()
    }
}
