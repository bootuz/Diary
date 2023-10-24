//
//  DailyRecordsRequest.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 22.10.2023.
//

import Foundation

enum DailyRecordsRequest {
    case dailyRecords(date: String)
}

extension DailyRecordsRequest: Request {
    var path: String {
        return "\(Constants.basePath)/daily/get"
    }

    var method: HTTPMethod {
        return .GET
    }

    var header: [String: String]? {
        return nil
    }

    var body: [String: Any]? {
        return nil
    }

    var query: [URLQueryItem]? {
        switch self {
            case .dailyRecords(let date):
                return [URLQueryItem(name: "day", value: date)]
        }
    }
}
