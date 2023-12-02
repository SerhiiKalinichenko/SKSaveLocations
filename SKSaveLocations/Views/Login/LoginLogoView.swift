//
//  LoginLogoView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 02.12.2023.
//

import SwiftUI

struct LoginLogoView: View {
    
    var body: some View {
        Image(.logo)
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)
            .clipShape(Circle())
    }
}
