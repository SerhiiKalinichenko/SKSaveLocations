//
//  RootView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 03.12.2023.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.sessionUser != nil {
                ProfileView()
            } else {
                LoginView()
            }
        }
    }
}
