//
//  NetworkResponse.swift
//  iOS-code-challenge-1
//
//  Created by Derek Kim on 2023-03-25.
//

import Foundation

struct ServerResponse: Codable {
    let error: ErrorResponse?
    let data: [Schedule]?
    
    enum CodingKeys: String, CodingKey {
        case error
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        error = try container.decodeIfPresent(ErrorResponse.self, forKey: .error)
        data = try container.decodeIfPresent([Schedule].self, forKey: .data)
    }
}

struct ErrorResponse: Codable {
    let message: String
}

