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
    private static let basePath = "/api/v0/sign-up"
    var path: String {
        switch self {
        case .resetPasswordInit:
            return "\(ResetPasswordRequest.basePath)/open/reset-password/init"
        case .resetPassword:
            return "\(ResetPasswordRequest.basePath)/open/reset-password"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .resetPasswordInit:
            return .get
        case .resetPassword:
            return .post
        }
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var body: [String : String]? {
        switch self {
        case .resetPasswordInit:
            return nil
        case .resetPassword(let data):
            return [
                "codeFromEmail": data.codeFromEmail,
                "newPassword": data.newPassword
            ]
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
