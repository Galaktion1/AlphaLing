// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - WelcomeElement
struct TimeTrackingModel: Codable {
    let id, taskID, taskUserID: Int?
    let note, startedAt, endedAt: String?
    let billable: Bool?
    let invoicePositionID, creditNotePositionID: JSONNull?
    let createdAt, modifiedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case taskID = "taskId"
        case taskUserID = "taskUserId"
        case note, startedAt, endedAt, billable
        case invoicePositionID = "invoicePositionId"
        case creditNotePositionID = "creditNotePositionId"
        case createdAt, modifiedAt
    }
}

typealias TimeTracking = [TimeTrackingModel?]

// MARK: - Encode/decode helpers



