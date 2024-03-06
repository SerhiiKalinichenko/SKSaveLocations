//
//  MapView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
//

import MapKit
import SwiftUI

struct MapView: View {
    @ObservedObject var viewModel: MapViewModel
    @Environment(\.dismiss) var dismiss
    @State var location: CLLocation?
    @State private var showBottomView = false
    @State private var tappedButton: MapButtonType?

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ZStack(alignment: .topLeading) {
                Map(position: $viewModel.position) {
                    if let locations = viewModel.routeLocations?.compactMap({ $0.coordinate }) {
                        MapPolyline(coordinates: locations, contourStyle: .straight)
                            .stroke(.blue, lineWidth: 3)
                            .mapOverlayLevel(level: .aboveLabels)
                    }
                    if let observedLocation = viewModel.observedLocation {
                        let user = viewModel.observedUser
                        Annotation(user?.name ?? "", coordinate: observedLocation, content: {
                            if let user {
                                ObservedUserImageView(user: user, imageHeight: 30)
                            } else {
                                ZStack {
                                    Circle()
                                        .foregroundStyle(.red)
                                    Image(systemName: "figure.wave")
                                        .padding(7)
                                }
                            }
                        })
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
                    .padding([.top, .horizontal], 16)
                    .presentationDetents([.medium, .large])
                    .presentationBackground(.thinMaterial)
                switch tappedButton {
                case .routes:
                    List(viewModel.routesList ?? [], id: \.id) { rout in
                        Text(rout.description ?? "Some rout")
                            .onTapGesture {
                                viewModel.getLocations(for: rout)
                                showBottomView = false
                            }
                    }
                    .listStyle(.automatic)
                    .scrollContentBackground(.hidden)
                case .observedUsers:
                    if viewModel.observedUsers?.count == 0 {
                        VStack {
                            Spacer()
                            if viewModel.observedUsers == nil {
                                ProgressView()
                                    .tint(.mainBlue)
                            } else {
                                Text("noObserved.users")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 25))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.mainBlue)
                                    .padding(.horizontal, 16)
                            }
                            Spacer()
                        }
                    } else {
                        List(viewModel.observedUsers ?? [], id: \.id) { user in
                            ObservedUserView(user: user)
                                .onTapGesture {
                                    viewModel.observeUser(user)
                                    showBottomView = false
                                }
                        }
                        .listStyle(.automatic)
                        .scrollContentBackground(.hidden)
                    }
                default:
                    EmptyView()
                }
            }
            Spacer()
        }
    }
}

#Preview {
    MapView(viewModel: MapViewModel(serviceHolder: ServiceHolderMock()))
}
