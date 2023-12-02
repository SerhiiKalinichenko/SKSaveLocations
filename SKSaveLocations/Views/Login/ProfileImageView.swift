//
//  ProfileImageView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 02.12.2023.
//

import SwiftUI

struct ProfileImageView: View {
    var image: Image?
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            let avatarImage = image ?? Image(.avatar)
            avatarImage
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .background(.gray)
                .clipShape(Circle())
                .shadow(radius: 4)
            Image(systemName: image == nil ? "person.crop.circle.fill.badge.plus" : "person.badge.plus")
                .scaledToFill()
                .frame(width: 25, height: 25)
                .foregroundStyle(.white)
                .background(.mainText)
                .clipShape(Circle())
        }
    }
}
