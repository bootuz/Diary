//
//  Pageble.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.10.2023.
//

import Foundation

struct Pageable: Codable {
    let page: Int?
    let size: Int?
    let sort: [String]?

    func toQueryItemArray() -> [URLQueryItem] {
        var array = [URLQueryItem]()
        if let page = self.page {
            array.append(URLQueryItem(name: "page", value: String(page)))
        }

        if let size = self.size {
            array.append(URLQueryItem(name: "size", value: String(size)))
        }

        if let sort = self.sort {
            array.append(URLQueryItem(name: "sort", value: sort.joined(separator: ",")))
        }
        return array
    }
}
