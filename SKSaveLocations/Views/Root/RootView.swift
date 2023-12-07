//
//  RootView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 03.12.2023.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var firebaseService: FirebaseService
    
    var body: some View {
        Group {
            if firebaseService.sessionUser == nil {
                let viewModel = LoginViewModel(firebaseService: firebaseService)
                LoginView(viewModel: viewModel)
            } else {
                let viewModel = MainTabViewModel(firebaseService: firebaseService)
                MainTabView(viewModel: viewModel)
            }
        }
    }
}
