//
//  Constants.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 18.10.2023.
//

import Foundation


struct Constants {
    static let tokenKey = "TOKEN_DATA"

    struct ErrorMessages {
        static let somethingWentWrong = "Something went wrong."
        static let invalidResponse = "Invalid response."
        static let invalidLoginOrPassword = "Invalid login or password."
        static let unauthorizedYouNeedToLoginFirst = "Unauthorized. You need to log in first."
        static let emailNotFound = "Email not found."
        static let invalidCode = "Invalid code."
    }
}
