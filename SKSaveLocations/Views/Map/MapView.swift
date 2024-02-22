//
//  MapView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 06.12.2023.
//

import MapKit
import SwiftUI

struct MapView: View {
    @ObservedObject var viewModel: MapViewModel
    @Environment(\.dismiss) var dismiss
    @State var location: CLLocation?
    @State private var showBottomView = false
    @State private var tappedButton: MapButtonType?
    private let botomViewHeights = stride(from: 0.1, through: 1, by: 0.45).map { PresentationDetent.fraction($0) }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ZStack(alignment: .topLeading) {
                Map(position: $viewModel.position) {
                    if let locations = viewModel.routeLocations?.compactMap({ $0.coordinate }) {
                        MapPolyline(coordinates: locations)
                            .stroke(.blue, lineWidth: 3)
                            .mapOverlayLevel(level: .aboveLabels)
                    }
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
            }
            .padding(.trailing, 16)
        }
        .sheet(isPresented: $showBottomView) {
            VStack {
                MapButtonsCollectionView(viewModel: viewModel, tappedButton: $tappedButton)
                    .frame(height: 50)
                    .padding(.horizontal, 16)
                    .presentationDetents([.height(100), .medium, .large])
                    .presentationBackground(.thinMaterial)
                switch tappedButton {
                case .routes:
                    List(viewModel.routesList ?? [], id: \.id) { rout in
                        Text("Rout: \(rout.description ?? "Some rout")")
                            .onTapGesture {
                                viewModel.getLocations(for: rout)
                                showBottomView = false
                            }
                    }
                    .listStyle(.automatic)
                    .scrollContentBackground(.hidden)
                default:
                    EmptyView()
                }
            }
            Spacer()
        }
        .task {
            viewModel.checkAuthorization()
        }
    }
}

#Preview {
    MapView(viewModel: MapViewModel(serviceHolder: ServiceHolderMock()))
}
