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
        if let method = request.httpMethod, let url = request.url {
            // swiftlint:disable:next no_direct_standard_out_logs
            print("DEBUG: [\(method)] \(url)")
        }
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw RequestError.invalidResponse(message: Constants.ErrorMessages.somethingWentWrong)
        }
        return (data, httpResponse)
    }
}
