//
//  RequestError.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 25.09.2023.
//

import Foundation

enum RequestError: Error {
    case decodeError(message: String)
    case notFound(message: String)
    case invalidURL
    case invalidResponse(message: String)
    case unauthorizedError(message: String)
    case wrongCredentials(message: String)
    case unexpectedStatusCodeError(statusCode: Int)
    case unknownError
}

extension RequestError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
            case .decodeError(let message):
                return message
            case .invalidURL:
                return ""
            case .invalidResponse(let message):
                return message
            case .unauthorizedError(let message):
                return message
            case .wrongCredentials(let message):
                return message
            case .unexpectedStatusCodeError(let statusCode):
                return String(statusCode)
            case .notFound(let message):
                return message
            case .unknownError:
                return "Unknown error"
        }
    }
}
