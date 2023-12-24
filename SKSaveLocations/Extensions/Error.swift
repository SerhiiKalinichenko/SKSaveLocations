//
//  Error.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 24.12.2023.
//

import Firebase
import Foundation

extension AuthErrorCode.Code {
    var description: String? {
        switch self {
        case .emailAlreadyInUse:
            return "error.email.alreadyInUse"
        case .userDisabled:
            return "error.account.disabled"
        case .operationNotAllowed:
            return "error.provider.disabled"
        case .invalidEmail:
            return "error.email.invalid"
        case .wrongPassword:
            return "error.wrongPassword"
        case .userNotFound:
            return "error.account.notFound"
        case .networkError:
            return "error.network"
        case .weakPassword:
            return "error.password.weak"
        case .missingEmail:
            return "error.email.missing"
        case .internalError:
            return "error.internal"
        case .invalidCustomToken:
            return "error.token"
        case .tooManyRequests:
            return "error.tooManyRequests"
        default:
            return "error.authentication"
        }
    }
}

extension FirestoreErrorCode.Code {
    var description: String? {
        switch self {
        case .cancelled:
            return "error.operation.cancelled"
        case .invalidArgument:
            return "error.invalidArgument"
        case .notFound:
            return "error.document.notFound"
        case .alreadyExists:
            return "error.document.alreadyExist"
        case .permissionDenied:
            return "error.permissionDenied"
        case .internal:
            return "error.internal"
        default:
            return nil
        }
    }
}

extension Error {
    var localizedDescription: String {
        let error = self as NSError
        if error.domain == AuthErrorDomain {
            if let code = AuthErrorCode.Code(rawValue: error.code), let errorString = code.description {
                return String(localized: String.LocalizationValue(errorString))
            }
        } else if error.domain == FirestoreErrorDomain {
            if let code = FirestoreErrorCode.Code(rawValue: error.code), let errorString = code.description {
                return String(localized: String.LocalizationValue(errorString))
            }
        }
        return error.localizedDescription
    }
}
