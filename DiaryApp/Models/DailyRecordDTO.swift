//
//  DailyRecordDTO.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 22.10.2023.
//

import Foundation

struct DailyRecordDTO: Codable {
    let user: UserDTO
    let day: String
    let calendarEvents: [CalendarEventDTO]
    let myPosts: [MyPostDTO]
}

struct CalendarEventDTO: Codable, Identifiable {
    let id: Int
    let accountId: Int
    let time: String
    let remindTime: String
    let title: String
    let description: String
    let notificationSent: Bool
}

struct MyPostDTO: Codable, Identifiable {
    let id: Int
    let author: AuthorDTO
    let title: String
    let text: String
    let isCheckedByAdmin: Bool?
    let isSpam: Bool?
    let privateLevel: PrivateLevel
    let emotion: Emotion
    let deleted: Bool
    let hiddenFromFeed: Bool?
    let createdDateTime: String
    let files: [String]
    let photos: [String]
    let commentCount: Int
}

struct UserDTO: Codable {
    let id: Int
    let email: String
    let name: String?
    let nickname: String
    let about: String?
    let enabled: Bool
    let role: Role
    let birthdate: String?
    let avatars: [String]
}
