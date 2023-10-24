//
//  ReactionsDTO.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.10.2023.
//

import Foundation

struct PageDTO<Content: Codable>: Codable {
    let totalPages: Int
    let totalElements: Int
    let pageable: PageableDTO
    let sort: Sort
    let first: Bool
    let last: Bool
    let size: Int
    let content: [Content]
    let number: Int
    let numberOfElements: Int
    let empty: Bool
}

struct PageableDTO: Codable {
    let pageNumber: Int
    let pageSize: Int
    let sort: Sort
    let offset: Int
    let paged: Bool
    let unpaged: Bool
}

struct Sort: Codable {
    let sorted, unsorted, empty: Bool
}
