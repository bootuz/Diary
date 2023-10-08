//
//  ResetPassword.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.09.2023.
//

import Foundation


struct UpdatePassword: Codable {
    let codeFromEmail: String
    let newPassword: String
}
