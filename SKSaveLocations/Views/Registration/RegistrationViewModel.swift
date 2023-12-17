//
//  RegistrationViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 04.12.2023.
//

import UIKit

final class RegistrationViewModel: ObservableObject {
    let firebaseService: any FirebaseServiceType
    @Published private(set) var name = ""
    @Published private(set) var email = ""
    @Published private(set) var password = ""
    @Published private(set) var confirmPassword = ""
    @Published private(set) var phoneNumber = ""
    
    var dataIsValidated: Bool {
        return name.count > 2 && email.count > 5 && password.count > 5 && password == confirmPassword
    }
    
    init(firebaseService: any FirebaseServiceType) {
        self.firebaseService = firebaseService
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
            try await firebaseService.createUser(email: email, password: password, name: name, phoneNumber: phoneNumber, image: image)
        }
    }
}
