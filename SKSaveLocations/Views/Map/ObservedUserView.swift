//
//  ObservedUserView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
//

import SwiftUI

struct ObservedUserView: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 8) {
            ObservedUserImageView(user: user)
            Text(user.name)
                .font(.system(size: 23))
                .fontWeight(.semibold)
                .foregroundStyle(.mainBlue)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .background()
        }
    }
}

struct ObservedUserImageView: View {
    let user: User
    var imageHeight = 40.0
    
    var body: some View {
        Group {
            if let image = user.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: imageHeight, height: imageHeight)
                    .overlay(Circle().stroke(.white, lineWidth: 3))
                    .shadow(radius: 4)
            } else {
                Circle()
                    .frame(width: imageHeight, height: imageHeight)
                    .foregroundStyle(.mainGray)
                    .overlay(
                        Text(user.name.initials)
                            .font(.system(size: 23))
                            .fontWeight(.semibold)
                            .foregroundStyle(.mainBlue)
                    )
            }
        }
    }
}
