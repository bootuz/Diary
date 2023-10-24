//
//  ResetPasswordRequest.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 07.10.2023.
//

import Foundation

enum ResetPasswordRequest {
    case resetPasswordInit(email: String)
    case resetPassword(data: UpdatePasswordDTO)
}

extension ResetPasswordRequest: Request {
    var path: String {
        switch self {
        case .resetPasswordInit:
            return "\(Constants.basePath)/sign-up/open/reset-password/init"
        case .resetPassword:
            return "\(Constants.basePath)/sign-up/open/reset-password"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .resetPasswordInit:
                return .GET
            case .resetPassword:
                return .POST
        }
    }
    
    var header: [String: String]? {
        return nil
    }
    
    var body: [String: Any]? {
        switch self {
            case .resetPasswordInit:
                return nil
            case .resetPassword(let data):
                return data.toDictionary()
        }
    }
    
    var query: [URLQueryItem]? {
        switch self {
            case .resetPasswordInit(let email):
                return [URLQueryItem(name: "email", value: email)]
            case .resetPassword:
                return nil
        }
    }
}
