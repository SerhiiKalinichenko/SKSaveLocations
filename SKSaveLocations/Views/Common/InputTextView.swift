//
//  InputTextView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 02.12.2023.
//

import SwiftUI

struct InputTextView: View {
    @Binding var text: String
    @State var hideText = true
    let title: LocalizedStringKey
    let placeholder: LocalizedStringKey
    var isSecureText = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 25))
                .fontWeight(.semibold)
                .foregroundStyle(.mainText)
            HStack {
                if isSecureText && hideText {
                    SecureField(placeholder, text: $text)
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                        .frame(height: 35)
                } else {
                    TextField(placeholder, text: $text)
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                        .frame(height: 35)
                }
                if isSecureText {
                    Spacer()
                    Button {
                        hideText.toggle()
                    } label: {
                        Image(systemName: hideText ? "eye" : "eye.slash")
                            .foregroundStyle(.mainText)
                    }
                }
            }
            Divider()
        }
    }
}
