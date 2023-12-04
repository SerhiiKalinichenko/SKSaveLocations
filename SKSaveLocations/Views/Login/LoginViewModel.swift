//
//  LoginViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 04.12.2023.
//

import Foundation

final class LoginViewModel: ObservableObject {
    let authService: any AuthServiceType
    @Published private(set) var email = ""
    @Published private(set) var password = ""
    
    var dataIsValidated: Bool {
        return email.count > 5 && password.count > 5
    }
    
    init(authService: any AuthServiceType) {
        self.authService = authService
    }
    
    func emailChanged(_ value: String) {
        email = value
    }
    
    func passwordChanged(_ value: String) {
        password = value
    }
    
    func logIn() {
        Task {
            try await authService.logIn(email: email, password: password)
        }
    }
}
