//
//  AuthUserMock.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
//

import Firebase

final class AuthUserMock: NSObject, UserInfo {
    
    var uid: String
    var providerID: String
    var phoneNumber: String?
    var displayName: String?
    var email: String?
    var photoURL: URL?
    
    init(uid: String) {
        self.uid = uid
        self.providerID = "0"
    }
}
