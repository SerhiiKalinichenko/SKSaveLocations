//
//  ServicesView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
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
            MapView(viewModel: MapViewModel(serviceHolder: ServiceHolder.shared))
        })
        .fullScreenCover(isPresented: $goToShareLocation, content: {
            SaveLocations(viewModel: SaveLocationsViewModel(serviceHolder: ServiceHolder.shared))
        })
        .task {
            viewModel.checkAuthorization()
        }
    }
}

#Preview {
    ServicesView(viewModel: ServicesViewModel(serviceHolder: ServiceHolderMock()))
}
