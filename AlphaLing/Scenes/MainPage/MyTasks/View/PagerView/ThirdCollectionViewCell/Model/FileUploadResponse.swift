//
//  FileUploadResponse.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 29.06.22.
//

import Foundation

struct FileUploadResponseModel: Codable {
    let origin: String?
    let originID: Int?
    let fileKey: String?
    let acl: [ACL]?
    let createdByID: Int?
    let uniqueKey: JSONNull?
    let filename, mimeType: String?
    let size: Int?
    let modifiedAt: String?
    let modifiedByID, id: Int?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case origin
        case originID = "originId"
        case fileKey, acl
        case createdByID = "createdById"
        case uniqueKey, filename, mimeType, size, modifiedAt
        case modifiedByID = "modifiedById"
        case id, createdAt
    }
}

// MARK: - ACL
struct ACL: Codable {
    let key, accessorType, accessorKey, accessRole: String?
}
