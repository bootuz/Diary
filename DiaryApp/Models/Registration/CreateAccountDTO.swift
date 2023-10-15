//
//  CreateAccount.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.09.2023.
//

import Foundation

struct CreateAccountDTO: Codable {
    let email: String
    let nickname: String
    let password: String
    var name: String? = nil
    var birthdate: String? = nil
    var about: String? = nil
}
