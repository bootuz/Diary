//
//  PostUpdateDTO.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.10.2023.
//

import Foundation

struct PostUpdateDTO: Codable, DictionaryConvertor {
    let id: Int
    let author: AuthorDTO
    let title: String
    let text: String
    let isCheckedByAdmin: Bool
    let isSpam: Bool
    let privateLevel: PrivateLevel
    let emotion: Emotion
    let deleted: Bool
    let hiddenFromFeed: Bool
    let createdDateTime: Date
    let files: [Data]
    let photos: [Data]
    let commendCount: Int
}
