//
//  ReactionDTO.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.10.2023.
//

import Foundation

struct ReactionDTO: Codable, DictionaryConvertor {
    let postId: Int
    let emojiReact: Reaction
    let subject: AuthorDTO
}
