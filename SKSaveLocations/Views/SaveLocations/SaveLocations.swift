//
//  SaveLocations.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
//

import SwiftUI

struct SaveLocations: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: SaveLocationsViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                Group {
                    RoundedButton(label: "trackPosition", icon: Image(systemName: "location")) {
                        viewModel.startTracking()
                    }
                    .opacity(viewModel.isTracking ? 0.3 : 1)
                    .disabled(viewModel.isTracking)
                    RoundedButton(label: "stopTracking", icon: Image(systemName: "location.slash")) {
                        viewModel.stopTracking()
                    }
                    .opacity(!viewModel.isTracking ? 0.3 : 1)
                    .disabled(!viewModel.isTracking)
                }
                .padding(.horizontal, 16)
                if let location = viewModel.lastLocation {
                    Text("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude), Altitude: \(location.altitude)")
                }
                List(viewModel.locations) { locationData in
                    Text("Lat: \(locationData.latitude), Long: \(locationData.longitude)")
                }
                Spacer()
            }
            .padding(.top, 50)
            Button {
               dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("👈🏾")
                    Text("back")
                        .foregroundStyle(Color.mainBlue)
                        .font(.system(size: 12))
                }
            }
            .frame(height: 44)
            .padding(.leading, 16)
        }
    }
}

#Preview {
    SaveLocations(viewModel: SaveLocationsViewModel(serviceHolder: ServiceHolderMock()))
}
