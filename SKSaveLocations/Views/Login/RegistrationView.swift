//
//  RegistrationView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 02.12.2023.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            MainRegistrationView()
            Button {
               dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("👈🏾")
                    Text("back")
                        .foregroundStyle(Color.mainBlue)
                        .font(.system(size: 12))
                }
            }
            .frame(height: 44)
            .padding(.leading, 16)
        }
    }
}

struct MainRegistrationView: View {
    @State private var image: Image?
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showImagePicker = false
    @State private var addedImage: UIImage?
    
    var body: some View {
        VStack {
            LoginLogoView()
                .opacity(0.7)
                .padding(.top, 10)
            ProfileImageView(image: image)
                .padding(.top, -20)
                .onTapGesture {
                    showImagePicker = true
                }
            VStack {
                InputTextView(text: $name, title: "name", placeholder: "namePlaceholder")
                InputTextView(text: $email, title: "email", placeholder: "emailPlaceholder")
                    .autocapitalization(.none)
                InputTextView(text: $password, title: "password", placeholder: "passwordPlaceholder", isSecureText: true)
                InputTextView(text: $confirmPassword, title: "confirmPassword", placeholder: "confirmPasswordPlaceholder", isSecureText: true)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            RoundedButton(label: "signIn") {
                debugPrint("SignIn Button tapped")
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
            Spacer()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $addedImage)
        }
        .onChange(of: addedImage) {
            loadImage()
        }
    }
    
    func loadImage() {
        guard let addedImage else {
            return
        }
        image = Image(uiImage: addedImage)
    }
}

#Preview {
    RegistrationView()
}
