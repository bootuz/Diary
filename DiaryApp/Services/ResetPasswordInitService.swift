//
//  ResetPasswordService.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 07.10.2023.
//

import Foundation

protocol ResetPasswordInitProtocol {
    func resetPasswordInit(email: String) async throws -> Response<String>
}

class ResetPasswordInitService: ResetPasswordInitProtocol {

    private var client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    func resetPasswordInit(email: String) async throws -> Response<String> {
        let (data, response) = try await client.perform(request: ResetPasswordRequest.resetPasswordInit(email: email).urlRequest)
        return try ResetPasswordInitMapper.map(data: data, response: response)
    }
}


struct ResetPasswordInitMapper {
    static func map(data: Data, response: HTTPURLResponse) throws -> Response<String> {
        if response.statusCode == 404 {
            throw RequestError.notFound(message: Constants.ErrorMessages.emailNotFound)
        }
        
        guard response.statusCode == 200 else {
            throw RequestError.invalidResponse(message: Constants.ErrorMessages.somethingWentWrong)
        }

        guard let data = try? JSONDecoder().decode(Response<String>.self, from: data) else {
            throw RequestError.decodeError
        }
        return data
    }
}
