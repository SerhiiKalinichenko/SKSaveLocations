//
//  RegistrationView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 02.12.2023.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: RegistrationViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            MainRegistrationView(viewModel: viewModel)
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
    @StateObject var viewModel: RegistrationViewModel
    @State private var image: Image?
    @State private var showImagePicker = false
    @State private var addedImage: UIImage?
    private var nameBinding: Binding<String> {
        Binding {
            viewModel.name
        } set: {
            viewModel.nameChanged($0)
        }
    }
    private var emailBinding: Binding<String> {
        Binding {
            viewModel.email
        } set: {
            viewModel.emailChanged($0)
        }
    }
    private var passwordBinding: Binding<String> {
        Binding {
            viewModel.password
        } set: {
            viewModel.passwordChanged($0)
        }
    }
    private var confirmPasswordBinding: Binding<String> {
        Binding {
            viewModel.confirmPassword
        } set: {
            viewModel.confirmPasswordChanged($0)
        }
    }

    var body: some View {
        ScrollView {
            VStack {
                LoginLogoView()
                    .opacity(0.7)
                    .padding(.top, 10)
                ProfileImageView(image: image, name: nameBinding.wrappedValue)
                    .padding(.top, -20)
                    .onTapGesture {
                        showImagePicker = true
                    }
                VStack {
                    InputTextView(text: nameBinding, title: "name", placeholder: "namePlaceholder")
                    InputTextView(text: emailBinding, title: "email", placeholder: "emailPlaceholder")
                        .autocapitalization(.none)
                    InputTextView(text: passwordBinding, title: "password", placeholder: "passwordPlaceholder", isSecureText: true)
                    InputTextView(text: confirmPasswordBinding, title: "confirmPassword", placeholder: "confirmPasswordPlaceholder", isSecureText: true)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                RoundedButton(label: "signIn") {
                    viewModel.createUser(image: addedImage)
                }
                .frame(height: 44)
                .padding(.horizontal, 16)
                .padding(.top, 20)
                .disabled(!viewModel.dataIsValidated)
                .opacity(viewModel.dataIsValidated ? 1 : 0.6)
                Spacer()
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $addedImage)
            }
            .onChange(of: addedImage) {
                loadImage()
            }
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
    RegistrationView(viewModel: RegistrationViewModel(authService: AuthServiceMock()))
}
