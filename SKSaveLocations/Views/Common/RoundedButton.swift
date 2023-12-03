//
//  RoundedButton.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 02.12.2023.
//

import SwiftUI

struct RoundedButton: View {
    let label: LocalizedStringKey
    let icon: Image? = nil
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 5) {
                if let icon {
                    icon
                }
                Text(label)
                    .foregroundStyle(.white)
                    .font(.system(size: 20))
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
        }
        .background(.mainBlue)
        .cornerRadius(12)
    }
}
