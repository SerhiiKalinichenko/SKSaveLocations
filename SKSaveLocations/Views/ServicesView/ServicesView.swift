//
//  ServicesView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 05.12.2023.
//

import SwiftUI

struct ServicesView: View {
    @StateObject var viewModel: ServicesViewModel
    // TODO: change navigation
    @State private var goToMap = false
    @State private var goToShareLocation = false
    
    var body: some View {
        NavigationView {
            List(viewModel.services) { service in
                RoundedButton(label: service.name, icon: service.image) {
                    switch service.type {
                    case .map:
                        goToMap = true
                    case .saveLocation:
                        goToShareLocation = true
                    }
                }
                .frame(height: 44)
                .navigationTitle("services")
            }
        }
        .fullScreenCover(isPresented: $goToMap, content: {
            MapView(viewModel: MapViewModel(firebaseService: viewModel.firebaseService))
        })
        .fullScreenCover(isPresented: $goToShareLocation, content: {
            SaveLocations(viewModel: SaveLocationsViewModel(firebaseService: viewModel.firebaseService))
        })
    }
}

#Preview {
    ServicesView(viewModel: ServicesViewModel(firebaseService: FirebaseServiceMock()))
}
