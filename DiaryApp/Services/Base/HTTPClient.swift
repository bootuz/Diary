//
//  HTTPClient.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 25.09.2023.
//

import Foundation


protocol HTTPClient {
    func perform(request: URLRequest) async throws -> (Data, HTTPURLResponse)
}

extension URLSession: HTTPClient {

    func perform(request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw RequestError.invalidResponse(message: "Something went wrong")
        }
        return (data, httpResponse)
    }
}
