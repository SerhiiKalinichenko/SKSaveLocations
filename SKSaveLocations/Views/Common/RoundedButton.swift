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
    @State private var isPressed = false
    
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
        .buttonStyle(PressEffectButtonStyle(buttonColor: buttonColor, captionColor: captionColor))
    }
}

struct PressEffectButtonStyle: ButtonStyle {
    let buttonColor: Color
    let captionColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(buttonColor)
            .foregroundColor(captionColor)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
