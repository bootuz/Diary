//
//  PrivateLevel.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.10.2023.
//

import Foundation

enum PrivateLevel: String, Codable {
    case PRIVATE, PUBLIC, FRIENDS

    var icon: String {
        switch self {
            case .PRIVATE:
                return "lock.fill"
            case .PUBLIC:
                return "globe"
            case .FRIENDS:
                return "person.2.fill"
        }
    }
}
