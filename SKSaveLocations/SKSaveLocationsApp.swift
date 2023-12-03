//
//  SKSaveLocationsApp.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 26.11.2023.
//

import Firebase
import SwiftUI

@main
struct SKSaveLocationsApp: App {
    @StateObject private var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(viewModel)
        }
    }
}
