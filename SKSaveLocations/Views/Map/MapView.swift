//
//  MapView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 06.12.2023.
//

import MapKit
import SwiftUI

struct MapView: View {
    var viewModel: MapViewModel
    @Environment(\.dismiss) var dismiss
    @State var location: CLLocation?
    @State private var position: MapCameraPosition = .automatic
    
    var body: some View {
//        VStack {
        ZStack(alignment: .topLeading) {
            Map(position: $position) {
                UserAnnotation()
            }
            .mapStyle(.hybrid(elevation: .realistic))
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            
            Button {
               dismiss()
            } label: {
                ZStack {
                    Circle()
                        .foregroundStyle(Color.mainBlue)
                        .opacity(0.3)
                    Image(systemName: "xmark.circle")
                        .foregroundStyle(.white)
                }
            }
            .frame(height: 44)
            .padding(.leading, 16)
            
        }
        
        
//            Text(location?.description ?? "Waiting for location")
//                .padding()
//                .foregroundColor(.secondary)
//            Button {
//                Task { await self.updateLocation() }
//            } label: {
//                Text("Get Location")
//            }
//        }
//        .padding()
        .task {
            viewModel.checkAuthorization()
        }
    }

    private func updateLocation() async {
        do {
            location = try await viewModel.locationService.currentLocation
            updateMapPosition()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    private func updateMapPosition() {
        if let location {
            let regionCenter = CLLocationCoordinate2D(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
            let regionSpan = MKCoordinateSpan(latitudeDelta: 0.125, longitudeDelta: 0.125)
            position = .region(MKCoordinateRegion(center: regionCenter, span: regionSpan))
        }
    }
}

//#Preview {
//    MapView()
//}
