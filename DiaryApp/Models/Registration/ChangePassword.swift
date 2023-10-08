//
//  ChangePassword.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.09.2023.
//

import Foundation

struct ChangePassword: Codable {
    let accountId: Int
    let oldPassword: String
    let newPassword: String
}
