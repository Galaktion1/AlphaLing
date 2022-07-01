//
//  DocumentFetchingResponseModel.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 28.06.22.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - WelcomeElement
struct DocumentFetchingResponseModel: Codable {
    let id: Int?
    let origin: String?
    let originID: Int?
    let uniqueKey: JSONNull?
    let filename, fileKey, mimeType: String?
    let size: Int?
    let createdAt, modifiedAt: String?
    let permissions: Permissions?

    enum CodingKeys: String, CodingKey {
        case id, origin
        case originID = "originId"
        case uniqueKey, filename, fileKey, mimeType, size, createdAt, modifiedAt
        case permissions = "_permissions"
    }
}

// MARK: - Permissions
struct Permissions: Codable {
    let read, comment, write, delete: Bool?
    let share: Bool?
}

typealias DocumentFetchingResponse = [DocumentFetchingResponseModel]

// MARK: - Encode/decode helpers


