//
//  ServicesView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 05.12.2023.
//

import SwiftUI

struct ServicesView: View {
    @StateObject var viewModel: ServicesViewModel
    @State private var selected: Service?
    
    var body: some View {
        NavigationView {
            List(viewModel.services) { service in
                RoundedButton(label: service.name, icon: service.image) {
                    self.selected = service
                    debugPrint("sssss")
                }
                .listRowBackground(self.selected?.id == service.id ? Color.clear : .clear)
                .navigationTitle("services")
            }
        }
    }
}

#Preview {
    ServicesView(viewModel: ServicesViewModel())
}
