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
        return .POST
    }
    
    var header: [String: String]? {
        return [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
    }
    
    var body: [String: Any]? {
        switch self {
            case .fetchToken(let creds):
                return creds.toDictionary()
            case .refreshToken(let refreshCreds):
                return refreshCreds.toDictionary()
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

    var urlRequest: URLRequest {
        get throws {
            var urlComponents = URLComponents()
            urlComponents.scheme = scheme
            urlComponents.host = host
            urlComponents.path = path

            if let query {
                urlComponents.queryItems = query
            }

            guard let url = urlComponents.url else {
                throw RequestError.invalidURL
            }

            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.timeoutInterval = 20
            header?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
            request.httpBody = urlComponents.query?.data(using: .utf8)
            return request
        }
    }
}

struct RefreshCreds: Codable, DictionaryConvertor {
    let grantType: String
    let token: String
}

struct AuthCreds: Codable, DictionaryConvertor {
    let username: String
    let password: String
    var grantType: String = "password"
    var authType: String = "email"
}
