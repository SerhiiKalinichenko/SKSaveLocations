//
//  ServicesView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 05.12.2023.
//

import SwiftUI

struct ServicesView: View {
    @StateObject var viewModel: ServicesViewModel
    @State private var goToMap = false
    
    var body: some View {
        NavigationView {
            List(viewModel.services) { service in
                RoundedButton(label: service.name, icon: service.image) {
                    goToMap = true
                }
                .frame(height: 44)
                .navigationTitle("services")
            }
        }
        .fullScreenCover(isPresented: $goToMap, content: {
            MapView(viewModel: MapViewModel())
        })
    }
}

#Preview {
    ServicesView(viewModel: ServicesViewModel())
}
