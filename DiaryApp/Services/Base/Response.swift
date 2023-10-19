//
//  Response.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 01.10.2023.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let message: String?
    let body: T?
}
