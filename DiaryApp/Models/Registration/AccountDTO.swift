//
//  AccountDTO.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.09.2023.
//

import Foundation

struct AccountDTO: Codable {
    let id: Int
    let email: String
    let name: String?
    let nickname: String
    let about: String?
    let enabled: Bool
    let role: Role
    let birthdate: String?
    let avatars: [String]?
}

struct Role: Codable {
    let id: Int
    let name: String
}
