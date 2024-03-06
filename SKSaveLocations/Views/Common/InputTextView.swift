//
//  InputTextView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
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
            HStack {
                Text(title)
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                    .foregroundStyle(.mainBlue)
                if isSecureText {
                    Button {
                        hideText.toggle()
                    } label: {
                        Image(systemName: hideText ? "eye" : "eye.slash")
                            .foregroundStyle(.mainBlue)
                    }
                }
            }
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
                if !text.isEmpty {
                    Button(
                        action: {
                            text = ""
                        },
                        label: {
                            Image(systemName: "xmark.circle")
                                .foregroundStyle(.gray)
                        }
                    )
                }
            }
            Divider()
        }
    }
}
