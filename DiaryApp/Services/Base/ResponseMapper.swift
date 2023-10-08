//
//  ResponseMapper.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 01.10.2023.
//

import Foundation


struct ResponseMapper {
    static func map<T>(data: Data, response: HTTPURLResponse) throws -> Response<T> where T : Decodable {
        guard response.statusCode == 200 else {
            throw RequestError.invalidResponse(message: "Invalid response")
        }

        guard let data = try? JSONDecoder().decode(Response<T>.self, from: data) else {
            throw RequestError.decodeError
        }
        return data
    }
}
