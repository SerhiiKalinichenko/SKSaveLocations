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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var firebaseService = FirebaseService()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(firebaseService)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
#if DEBUG
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
#endif
        FirebaseApp.configure()
        return true
    }
}
