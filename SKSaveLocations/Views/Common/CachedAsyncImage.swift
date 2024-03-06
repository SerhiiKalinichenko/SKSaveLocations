//
//  CachedAsyncImage.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 06.03.2024.
//

import SwiftUI

@MainActor
struct CachedAsyncImage<ImageView: View, PlaceholderView: View>: View {
    private var url: URL?
    @ViewBuilder private var content: (Image) -> ImageView
    @ViewBuilder private var placeholder: () -> PlaceholderView
    @State private var uiImage: UIImage?
    
    init(url: URL?, @ViewBuilder content: @escaping (Image) -> ImageView, @ViewBuilder placeholder: @escaping () -> PlaceholderView) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }
    
    var body: some View {
        VStack {
            if let uiImage {
                content(Image(uiImage: uiImage))
            } else {
                placeholder()
                    .onAppear {
                        Task {
                            uiImage = await ImageLoader.loadImage(url: url)
                        }
                    }
            }
        }
    }
}
