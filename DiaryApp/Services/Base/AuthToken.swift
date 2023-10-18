//
//  AuthService.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.09.2023.
//

import Foundation


struct AuthToken: Codable {
    let accessToken: String
    let refreshToken: String
    let tokenType: String
    let expiresIn: Int
    let scope: String
    let jti: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope
        case jti
    }

    private func isTokenDateExpired(timeInterval: Int) -> Bool {
        let expiringDate = Date(timeIntervalSince1970: TimeInterval(timeInterval))
        return Date() > expiringDate
    }

    func isValid() -> Bool {
        return !isTokenDateExpired(timeInterval: expiresIn)
    }
}
