//
//  LoginView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 02.12.2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel
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
    
    var body: some View {
        NavigationStack {
            VStack {
                LoginLogoView()
                    .opacity(0.7)
                    .padding(.top, 10)
                VStack {
                    InputTextView(text: emailBinding, title: "email", placeholder: "emailPlaceholder")
                        .autocapitalization(.none)
                    InputTextView(text: passwordBinding, title: "password", placeholder: "passwordPlaceholder", isSecureText: true)
                }
                .padding(.horizontal)
                .padding(.top, 40)
                RoundedButton(label: "logIn") {
                    viewModel.logIn()
                }
                .frame(height: 44)
                .disabled(!viewModel.dataIsValidated)
                .opacity(viewModel.dataIsValidated ? 1 : 0.6)
                .padding(.horizontal, 16)
                .padding(.top, 20)
                Spacer()
                NavigationLink {
                    let regViewModel = RegistrationViewModel(serviceHolder: ServiceHolder.shared)
                    RegistrationView(viewModel: regViewModel)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("login.dontHaveAccount")
                        Text("signIn")
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.mainBlue)
                    .font(.system(size: 17))
                }
            }
        }
        .showAlert($viewModel.alert)
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel(serviceHolder: ServiceHolderMock()))
}
