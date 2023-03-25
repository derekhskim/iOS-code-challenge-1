//
//  NetworkResponse.swift
//  iOS-code-challenge-1
//
//  Created by Derek Kim on 2023-03-25.
//

import Foundation

struct ServerResponse: Codable {
    let error: ErrorResponse?
}

struct ErrorResponse: Codable {
    let message: String
}

