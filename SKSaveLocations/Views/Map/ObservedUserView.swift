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
            Group {
                if let imageURL = user.avatarURL {
                    CachedAsyncImage(url: imageURL) {image in
                        image
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    } placeholder: {
                        ProgressView()
                            .tint(.mainBlue)
                    }
                    .frame(width: 40, height: 40)
                } else {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.mainGray)
                        .overlay(
                            Text(user.name.initials)
                                .font(.system(size: 25))
                                .fontWeight(.semibold)
                                .foregroundStyle(.mainBlue)
                        )
                }
            }
            Text(user.name)
                .font(.system(size: 23))
                .fontWeight(.semibold)
                .foregroundStyle(.mainBlue)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .background()
        }
    }
}
