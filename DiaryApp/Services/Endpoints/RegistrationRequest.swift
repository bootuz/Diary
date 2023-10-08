//
//  RegistrationEndpoint.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 26.09.2023.
//

import Foundation


enum RegistrationRequest {
    case createAccount(data: CreateAccount)
    case changePassword(data: ChangePassword)
    case checkNickname(nickName: String)
    case activateAccount(code: String)
    case checkEmail(email: String)
}

extension RegistrationRequest: Request {

    private static let basePath: String = "/api/v0/sign-up"
    var path: String {
        switch self {
            case .createAccount:
                return "\(RegistrationRequest.basePath)/open/create"
            case .changePassword:
                return "\(RegistrationRequest.basePath)/changePassword"
            case .checkNickname:
                return "\(RegistrationRequest.basePath)/open/checkNickname"
            case .activateAccount(let code):
                return "\(RegistrationRequest.basePath)/open/activate/\(code)"
            case .checkEmail:
                return "\(RegistrationRequest.basePath)/open/checkEmail"

        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .createAccount, .changePassword:
                return .post

            case .checkNickname, .activateAccount, .checkEmail:
                return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
            case .createAccount, .changePassword:
                return [
                    "Content-Type": "application/json"
                ]
            case .checkNickname, .activateAccount, .checkEmail:
                return nil
        }
    }
    
    var body: [String : String]? {
        switch self {
            case .createAccount(let data):
                return [
                    "email": data.email,
                    "nickname": data.nickname,
                    "password": data.password,
                    "about": data.about ?? "",
                    "birthdate": data.birthdate ?? Date().ISO8601Format(),
                    "name": data.name ?? ""
                ]
            case .changePassword(let data):
                return [
                    "accountId": "\(data.accountId)",
                    "newPassword": data.newPassword,
                    "oldPassword": data.oldPassword
                ]
            case .checkNickname:
                return nil
            case .activateAccount:
                return nil
            case .checkEmail:
                return nil
        }
    }

    var query: [URLQueryItem]? {
        switch self {
            case .checkNickname(let nickName):
                return [URLQueryItem(name: "nickname", value: nickName)]
            case .checkEmail(let email):
                return [URLQueryItem(name: "email", value: email)]
            default:
                return nil
        }
    }
}
