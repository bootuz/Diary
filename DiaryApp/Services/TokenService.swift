//
//  AuthenticationService.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 01.10.2023.
//

import Foundation

protocol TokenProvider {
    func fetchToken(with creds: AuthCreds) async throws -> AuthToken
    func refreshToken(creds: RefreshCreds) async throws -> AuthToken
    func validToken(forceRefresh: Bool) async throws -> AuthToken
    func setToken(_ token: AuthToken)
    func removeToken()
    func getToken() -> AuthToken?
}

class TokenService: TokenProvider {

    private let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    private var currentToken: AuthToken? {
        if let tokenData = UserDefaults.standard.value(forKey: Constants.tokenKey) as? Data {
            return try? JSONDecoder().decode(AuthToken.self, from: tokenData)
        } else {
            return nil
        }
    }

    func getToken() -> AuthToken? {
        return self.currentToken
    }

    func fetchToken(with creds: AuthCreds) async throws -> AuthToken {
        let (data, response) = try await client.perform(request: AuthRequest.fetchToken(creds: creds).urlRequest)
        return try TokenMapper.map(data: data, response: response)
    }

    func refreshToken(creds: RefreshCreds) async throws -> AuthToken {
        let (data, response) = try await client.perform(request: AuthRequest.refreshToken(refreshCreds: creds).urlRequest)
        return try TokenMapper.map(data: data, response: response)
    }

    func validToken(forceRefresh: Bool = false) async throws -> AuthToken {
        guard let authToken = self.currentToken else {
            throw RequestError.unauthorizedError(message: Constants.ErrorMessages.unauthorizedYouNeedToLoginFirst)
        }

        if authToken.isValid(), !forceRefresh {
            return authToken
        }
        return try await refreshToken(creds: RefreshCreds(grantType: "refresh_token", token: authToken.refreshToken))
    }

    func setToken(_ token: AuthToken) {
        if let dataToken = try? JSONEncoder().encode(token) {
            UserDefaults.standard.set(dataToken, forKey: Constants.tokenKey)
        }
    }

    func removeToken() {
        UserDefaults.standard.removeObject(forKey: Constants.tokenKey)
    }
}


struct TokenMapper {
    static func map(data: Data, response: HTTPURLResponse) throws -> AuthToken {
        if response.statusCode == 400 {
            throw RequestError.wrongCredentials(message: Constants.ErrorMessages.invalidLoginOrPassword)
        }

        guard response.statusCode == 200 else {
            throw RequestError.invalidResponse(message: Constants.ErrorMessages.somethingWentWrong)
        }

        guard let data = try? JSONDecoder().decode(AuthToken.self, from: data) else {
            throw RequestError.decodeError
        }
        return data
    }
}
