//
//  MapButtonsCollectionView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 17.12.2023.
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
                        .onTapGesture {
                            if item.type == .routes {
                                viewModel.getRoutesList()
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
