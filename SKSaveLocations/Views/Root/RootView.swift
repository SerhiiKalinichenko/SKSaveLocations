//
//  RootView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 03.12.2023.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        Group {
            if authService.sessionUser == nil {
                let viewModel = LoginViewModel(authService: authService)
                LoginView(viewModel: viewModel)
            } else {
                let viewModel = MainTabViewModel(authService: authService)
                MainTabView(viewModel: viewModel)
            }
        }
    }
}
