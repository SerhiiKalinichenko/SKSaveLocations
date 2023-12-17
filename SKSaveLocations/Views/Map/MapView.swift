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
    @State private var showBottomView = false
    private let botomViewHeights = stride(from: 0.1, through: 0.7, by: 0.35).map { PresentationDetent.fraction($0) }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
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
                RoundMapButtonView(systemIconName: "xmark.circle") {
                    dismiss()
                }
                .padding(.leading, 16)
            }
            RoundMapButtonView(systemIconName: "map") {
                showBottomView.toggle()
                //viewModel.getRoutesList()
            }
            .padding(.trailing, 16)
        }
        .sheet(isPresented: $showBottomView) {
            Text("This Bottom View")
                .presentationDetents(Set(botomViewHeights))
                .presentationBackground(.thinMaterial)
        }
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
