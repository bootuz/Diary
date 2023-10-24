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
                return "\(Constants.basePath)/sign-up/open/create"
            case .changePassword:
                return "\(Constants.basePath)/sign-up/changePassword"
            case .checkNickname:
                return "\(Constants.basePath)/sign-up/open/checkNickname"
            case .activateAccount(let code):
                return "\(Constants.basePath)/sign-up/open/activate/\(code)"
            case .checkEmail:
                return "\(Constants.basePath)/sign-up/open/checkEmail"

        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .createAccount, .changePassword:
                return .POST
            case .checkNickname, .activateAccount, .checkEmail:
                return .GET
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
    
    var body: [String: Any]? {
        switch self {
            case .createAccount(let data):
                return data.toDictionary()
            case .changePassword(let data):
                return data.toDictionary()
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
