//
//  RegistrationViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 04.12.2023.
//

import UIKit

final class RegistrationViewModel: ObservableObject {
    let authService: any AuthServiceType
    @Published private(set) var name = ""
    @Published private(set) var email = ""
    @Published private(set) var password = ""
    @Published private(set) var confirmPassword = ""
    @Published private(set) var phoneNumber = ""
    
    @MainActor var user: User? {
        authService.user
    }
    
    var dataIsValidated: Bool {
        return name.count > 2 && email.count > 5 && password.count > 5 && password == confirmPassword
    }
    
    init(authService: any AuthServiceType) {
        self.authService = authService
    }
    
    func nameChanged(_ value: String) {
        name = value
    }
    
    func emailChanged(_ value: String) {
        email = value
    }
    
    func passwordChanged(_ value: String) {
        password = value
    }
    
    func confirmPasswordChanged(_ value: String) {
        confirmPassword = value
    }
    
    func createUser(image: UIImage?) {
        Task {
            try await authService.createUser(email: email, password: password, name: name, phoneNumber: phoneNumber, image: image)
        }
    }
}
