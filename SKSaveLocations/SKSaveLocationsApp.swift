//
//  SKSaveLocationsApp.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
//

import Firebase
import SwiftUI

@main
struct SKSaveLocationsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var session = UserSession.shared
    
    var body: some Scene {
        WindowGroup {
            switch session.state {
            case .undefined:
                ZStack {
                    Image(.logo)
                        .opacity(0.1)
                    ProgressView()
                        .tint(.mainBlue)
                }
                .toolbar(.hidden, for: .tabBar)
            case .closed:
                let viewModel = LoginViewModel(serviceHolder: ServiceHolder.shared)
                LoginView(viewModel: viewModel)
            case .open:
                let viewModel = MainTabViewModel()
                MainTabView(viewModel: viewModel)
            }
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
        let _ = ServiceHolder.shared
        return true
    }
}
