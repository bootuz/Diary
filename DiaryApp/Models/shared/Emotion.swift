//
//  Emotion.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.10.2023.
//

import Foundation

enum Emotion: String, Codable {
    case CRY, SAD, NEUTRAL, HAPPY, AMAZING, NONE

    var emoji: String {
        switch self {
            case .CRY:
                return "😭"
            case .SAD:
                return "😔"
            case .NEUTRAL:
                return "😐"
            case .HAPPY:
                return "☺️"
            case .AMAZING:
                return "🤩"
            case .NONE:
                return ""
        }
    }
}
