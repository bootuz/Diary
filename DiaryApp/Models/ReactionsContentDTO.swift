//
//  ReactionsContentDTO.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.10.2023.
//

import Foundation

struct ReactionsContentDTO: Codable {
    let postId: Int
    let emojiReact: String
    let subject: SubjectDTO
}

struct SubjectDTO: Codable {
    let accountId: Int
    let nickname: String
    let avatar: String
}
