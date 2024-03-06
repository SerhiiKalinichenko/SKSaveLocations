//
//  ProfileImageView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
//

import SwiftUI

struct ProfileImageView: View {
    var imageURL: URL?
    var image: Image?
    var name: String = ""
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Group {
                if let avatarImage = image {
                    avatarImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                } else if let imageURL {
                    AsyncImage(url: imageURL) {image in
                        image
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    } placeholder: {
                        ProgressView()
                            .tint(.mainBlue)
                    }
                    .frame(width: 70, height: 70)
                } else {
                    Circle()
                        .frame(width: 70, height: 70)
                        .foregroundStyle(.mainGray)
                        .overlay(
                            Text(name.initials)
                                .font(.system(size: 25))
                                .fontWeight(.semibold)
                                .foregroundStyle(.mainBlue)
                        )
                }
            }
            Image(systemName: image == nil ? "person.crop.circle.fill.badge.plus" : "person.badge.plus")
                .scaledToFill()
                .frame(width: 25, height: 25)
                .foregroundStyle(.white)
                .background(.mainBlue)
                .clipShape(Circle())
        }
    }
}

#Preview {
    ProfileImageView()
}
