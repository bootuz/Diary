//
//  BearerAuthenticationDecorator.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 01.10.2023.
//

import Foundation

class BearerAuthDecorator: HTTPClient {
    let client: HTTPClient
    let tokenProvider: TokenProvider

    init(client: HTTPClient, tokenProvider: TokenProvider) {
        self.client = client
        self.tokenProvider = tokenProvider
    }

    func perform(request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        var newRequest = request
        let authToken = try await tokenProvider.validToken(forceRefresh: false)
        newRequest.addValue("Bearer \(authToken.accessToken)", forHTTPHeaderField: "Authorization")
        return try await client.perform(request: newRequest)
    }
}
