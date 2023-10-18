//
//  ActivateAccountService.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 17.10.2023.
//

import Foundation

protocol ActivateAccountProtocol {
    func activateAccount(code: String) async throws -> Response<String>
}


class ActivateAccountService: ActivateAccountProtocol {
    
    private var client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    func activateAccount(code: String) async throws -> Response<String> {
        let (data, response) = try await client.perform(request: RegistrationRequest.activateAccount(code: code).makeRequest)
        return try ActivateAccountMapper.map(data: data, response: response)
    }
}


struct ActivateAccountMapper {
    static func map(data: Data, response: HTTPURLResponse) throws -> Response<String> {
        if response.statusCode == 404 {
            throw RequestError.notFound(message: "Invalid code.")
        }

        guard response.statusCode == 200 else {
            throw RequestError.invalidResponse(message: "Something went wrong.")
        }

        guard let data = try? JSONDecoder().decode(Response<String>.self, from: data) else {
            throw RequestError.decodeError
        }
        return data

    }
}

