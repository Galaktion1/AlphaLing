//
//  UserAuthModel.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 31.05.22.
//

import Foundation

struct SuccessfullyResponse: Codable {
    let status: Int?
    let error: String?
    let accessToken: String?
    
    private enum CodingKeys: String, CodingKey {
        case status, error, accessToken = "access_token"
    }
    
}
