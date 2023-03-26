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

    enum CodingKeys: String, CodingKey {
        case courseName = "course_name"
        case room
        case startTime = "start_time"
        case endTime = "end_time"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        courseName = try container.decode(String.self, forKey: .courseName)
        room = try container.decode(String.self, forKey: .room)

        let startTimeString = try container.decode(String.self, forKey: .startTime)
        let endTimeString = try container.decode(String.self, forKey: .endTime)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_CA")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        guard let startDate = dateFormatter.date(from: startTimeString) else {
            throw DecodingError.dataCorruptedError(forKey: .startTime, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }

        guard let endDate = dateFormatter.date(from: endTimeString) else {
            throw DecodingError.dataCorruptedError(forKey: .endTime, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }

        startTime = startDate
        endTime = endDate
    }
}
