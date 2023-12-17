//
//  RoundMapButtonView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 13.12.2023.
//

import SwiftUI

struct RoundMapButtonView: View {
    let systemIconName: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Circle()
                    .foregroundStyle(Color.mainBlue)
                    .opacity(0.4)
                Image(systemName: systemIconName)
                    .foregroundStyle(.white)
            }
        }
        .frame(height: 44)
    }
}

#Preview {
    RoundMapButtonView(systemIconName: "xmark.circle", action: {})
}
