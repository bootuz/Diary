//
//  AuthEndpoint.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 25.09.2023.
//

import Foundation

enum AuthRequest {
    case fetchToken(creds: AuthCreds)
    case refreshToken(refreshCreds: RefreshCreds)
}

extension AuthRequest: Request {

    var path: String {
        return "/oauth/token"
    }

    var method: HTTPMethod {
        return .post
    }
    
    var header: [String : String]? {
        return [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
    }
    
    var body: [String : String]? {
        switch self {
        case .fetchToken(let creds):
            return [
                "username": creds.username,
                "password": creds.password,
                "grant_type": creds.grantType,
                "authType": creds.authType
            ]
        case .refreshToken(let refreshCreds):
            return [
                "grant_type": refreshCreds.grantType,
                "token": refreshCreds.token
            ]
        }
    }

    var query: [URLQueryItem]? {
        switch self {
            case .fetchToken(let creds):
                return [
                    URLQueryItem(name: "username", value: creds.username),
                    URLQueryItem(name: "password", value: creds.password),
                    URLQueryItem(name: "grant_type", value: creds.grantType),
                    URLQueryItem(name: "auth_type", value: creds.authType)
                ]
            case .refreshToken(let refreshCreds):
                return [
                    URLQueryItem(name: "grant_type", value: refreshCreds.grantType),
                    URLQueryItem(name: "token", value: refreshCreds.token)
                ]
        }
    }
}

struct RefreshCreds: Codable {
    let grantType: String
    let token: String
}

struct AuthCreds: Codable {
    let username: String
    let password: String
    var grantType: String = "password"
    var authType: String = "email"
}
