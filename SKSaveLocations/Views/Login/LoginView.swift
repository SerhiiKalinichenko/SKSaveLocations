//
//  LoginView.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 02.12.2023.
//

import SwiftUI
import UIKit

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                LoginLogoView()
                    .opacity(0.7)
                    .padding(.top, 10)
                VStack {
                    InputTextView(text: $email, title: "email", placeholder: "emailPlaceholder")
                        .autocapitalization(.none)
                    InputTextView(text: $password, title: "password", placeholder: "passwordPlaceholder", isSecureText: true)
                }
                .padding(.horizontal)
                .padding(.top, 40)
                RoundedButton(label: "logIn") {
                    debugPrint("Button tapped")
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
                Spacer()
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("login.dontHaveAccount")
                        Text("signIn")
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.mainText)
                    .font(.system(size: 17))
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
