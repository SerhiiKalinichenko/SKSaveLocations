//
//  MapButtonsCollectionView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
//

import SwiftUI

struct MapButtonsCollectionView<VM>: View where VM: MapViewModelType {
    @ObservedObject var viewModel: VM
    @Binding var tappedButton: MapButtonType?
    
    let config = [
        GridItem(.fixed(70))
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: config, alignment: .center) {
                ForEach(viewModel.mapButtonData) { item in
                    Group {
                        VStack {
                            item.image
                            Text(item.name)
                        }
                        .foregroundStyle(tappedButton == item.type ? .mainBlue : .gray)
                        .onTapGesture {
                            switch item.type {
                            case .routes:
                                viewModel.getRoutesList()
                            case .observedUsers:
                                viewModel.getObservedUsersList()
                            default:
                                break
                            }
                            tappedButton = item.type
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    MapButtonsCollectionView()
//}
