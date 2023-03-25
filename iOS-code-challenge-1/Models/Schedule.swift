//
//  Schedule.swift
//  iOS-code-challenge-1
//
//  Created by Derek Kim on 2023-03-24.
//

import Foundation

struct Schedule: Codable {
    let courseName: String
    let room: String
    let startTime: Date
    let endTime: Date
}
