//
//  Endpoint.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 25.09.2023.
//

import Foundation

protocol Request {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var query: [URLQueryItem]? { get }
    var urlRequest: URLRequest { get throws }
}

extension Request {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "diary-backend-ef6c3f08e86f.herokuapp.com"
    }

    var urlRequest: URLRequest {
        get throws {
            var urlComponents = URLComponents()
            urlComponents.scheme = scheme
            urlComponents.host = host
            urlComponents.path = path
            urlComponents.queryItems = query

            guard let url = urlComponents.url else {
                throw RequestError.invalidURL
            }

            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.timeoutInterval = 20
            header?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
            if let body = body {
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            }
            return request
        }
    }
}
