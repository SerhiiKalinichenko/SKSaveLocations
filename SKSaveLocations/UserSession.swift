//
//  UserSession.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 25.12.2023.
//

import Foundation

enum UserSessionState {
    case closed
    case open
    case undefined
}

final class UserSession: ObservableObject {
    
    static let shared = UserSession()
    
    @Published var user: User? {
        didSet {
            state = user == nil ? .closed : .open
        }
    }
    
    @Published var state = UserSessionState.undefined
}
