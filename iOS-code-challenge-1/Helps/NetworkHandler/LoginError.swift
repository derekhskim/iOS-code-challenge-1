//
//  NetworkError.swift
//  iOS-code-challenge-1
//
//  Created by Derek Kim on 2023-03-25.
//

import Foundation

enum LoginError: LocalizedError {
    case emailNotFound
    case passwordInvalid
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .emailNotFound:
            return "Email not found. Please check your email address."
        case .passwordInvalid:
            return "Invalid password. Please check your password."
        case .unknownError:
            return "Unknown error has occured. Please try again."
        }
    }
}
