//
//  MainTabView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var viewModel: MainTabViewModel
    
    var body: some View {
        TabView {
            ServicesView(viewModel: viewModel.servicesVM)
                .tabItem {
                    Label("services", systemImage: "signpost.right.and.left")
                }
            ProfileView(viewModel: viewModel.profileVM)
                .tabItem {
                    Label("profile", systemImage: "gearshape.fill")
                }
        }
        .accentColor(.mainBlue)
    }
}
