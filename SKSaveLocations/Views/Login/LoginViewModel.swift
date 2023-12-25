//
//  LoginViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 04.12.2023.
//

import Firebase
import SwiftUI

final class LoginViewModel: ObservableObject {
    let userService: any UserServiceType
    let alertTitle: LocalizedStringKey = "error"
    @Published private(set) var email = ""
    @Published private(set) var password = ""
    @Published var alert: AlertType?
    
    var dataIsValidated: Bool {
        return email.count > 5 && password.count > 5
    }
    
    init(serviceHolder: ServiceHolderType) {
        self.userService = serviceHolder.getUserService()
    }
    
    func emailChanged(_ value: String) {
        email = value
    }
    
    func passwordChanged(_ value: String) {
        password = value
    }
    
    func logIn() {
        Task {
            do {
                try await userService.logIn(email: email, password: password)
            } catch let error {
                alert = .error(error)
            }
        }
    }
}
