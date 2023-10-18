//
//  BasicAuthDecorator.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 01.10.2023.
//

import Foundation


class BasicAuthDecorator: HTTPClient {
    let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    func perform(request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        var newRequest = request
        let authData = ("client:secret").data(using: .utf8)?.base64EncodedString()
        newRequest.addValue("Basic \(authData ?? "")", forHTTPHeaderField: "Authorization")
        return try await client.perform(request: newRequest)
    }
}
