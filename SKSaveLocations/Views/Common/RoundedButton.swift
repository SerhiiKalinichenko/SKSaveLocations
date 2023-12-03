//
//  RoundedButton.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 02.12.2023.
//

import SwiftUI

struct RoundedButton: View {
    let label: LocalizedStringKey
    var icon: Image? = nil
    var buttonColor = Color.mainBlue
    var captionColor = Color.white
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 5) {
                if let icon {
                    icon
                        .foregroundStyle(captionColor)
                }
                Text(label)
                    .foregroundStyle(captionColor)
                    .font(.system(size: 20))
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
        }
        .background(buttonColor)
        .cornerRadius(12)
    }
}
