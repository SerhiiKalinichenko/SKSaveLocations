//
//  ProfileViewModel.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 04.12.2023.
//

import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    let firebaseService: any FirebaseServiceType

    init(firebaseService: any FirebaseServiceType) {
        self.firebaseService = firebaseService
    }
    
    func logOut() {
        firebaseService.logOut()
    }
    
    func deleteAccount() {
        firebaseService.deleteAccount()
    }
}
