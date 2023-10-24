//
//  Reaction.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.10.2023.
//

import Foundation

enum Reaction: String, Codable {
    case LIKE, LOVE, SORRY, LAUGH, HORRIBLE, CONGRATS

    var emoji: String {
        switch self {
            case .LIKE:
                return "👍"
            case .LOVE:
                return "❤️"
            case .SORRY:
                return "😔"
            case .LAUGH:
                return "😂"
            case .HORRIBLE:
                return "😠"
            case .CONGRATS:
                return "👏"
        }
    }
}
