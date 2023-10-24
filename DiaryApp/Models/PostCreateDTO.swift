//
//  PostCreateDTO.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.10.2023.
//

import Foundation

struct PostCreateDTO: Codable, DictionaryConvertor {
    let title: String
    let text: String
    let emotion: Emotion
    let rivateLevel: PrivateLevel
    let files: [Data]
}
