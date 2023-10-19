//
//  RegistrationEndpoint.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 26.09.2023.
//

import Foundation

enum RegistrationRequest {
    case createAccount(data: CreateAccountDTO)
    case changePassword(data: ChangePasswordDTO)
    case checkNickname(nickName: String)
    case activateAccount(code: String)
    case checkEmail(email: String)
}

extension RegistrationRequest: Request {

    var path: String {
        switch self {
            case .createAccount:
                return "\(Constants.basePath)/open/create"
            case .changePassword:
                return "\(Constants.basePath)/changePassword"
            case .checkNickname:
                return "\(Constants.basePath)/open/checkNickname"
            case .activateAccount(let code):
                return "\(Constants.basePath)/open/activate/\(code)"
            case .checkEmail:
                return "\(Constants.basePath)/open/checkEmail"

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
    
    var header: [String: String]? {
        switch self {
            case .createAccount, .changePassword:
                return [
                    "Content-Type": "application/json"
                ]
            default:
                return nil
        }
    }
    
    var body: [String: String]? {
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
            default:
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
