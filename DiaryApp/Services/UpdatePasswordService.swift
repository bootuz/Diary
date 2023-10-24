//
//  ResetPasswordService.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 07.10.2023.
//

import Foundation

protocol UpdatePasswordProtocol {
    func updatePassword(data: UpdatePasswordDTO) async throws -> Response<String>
}

class UpdatePasswordService: UpdatePasswordProtocol {
    
    private var client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    func updatePassword(data: UpdatePasswordDTO) async throws -> Response<String> {
        let (data, response) = try await client.perform(request: ResetPasswordRequest.resetPassword(data: data).urlRequest)
        return try ResetPasswordMapper.map(data: data, response: response)
    }
}

struct ResetPasswordMapper {
    static func map(data: Data, response: HTTPURLResponse) throws -> Response<String> {
        
        guard let data = try? JSONDecoder().decode(Response<String>.self, from: data) else {
            throw RequestError.decodeError(message: "failed to decode response")
        }
        return data
    }
}
