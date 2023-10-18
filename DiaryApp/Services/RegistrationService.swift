//
//  RegistrationService.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.09.2023.
//

import Foundation


protocol RegistrationProtocol {
    func createAccount(data: CreateAccountDTO) async throws -> Response<AccountDTO>
    func checkNickname(nickName: String) async throws -> Response<Bool>
    func checkEmail(email: String) async throws -> Response<Bool>
}


class RegistrationService: RegistrationProtocol {

    private var client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    func createAccount(data: CreateAccountDTO) async throws -> Response<AccountDTO> {
        let (data, response) = try await client.perform(request: RegistrationRequest.createAccount(data: data).urlRequest)
        return try ResponseMapper.map(data: data, response: response)
    }

    func checkNickname(nickName: String) async throws -> Response<Bool> {
        let (data, response) = try await client.perform(request: RegistrationRequest.checkNickname(nickName: nickName).urlRequest)
        return try ResponseMapper.map(data: data, response: response)
    }

    func checkEmail(email: String) async throws -> Response<Bool> {
        let (data, response) = try await client.perform(request: RegistrationRequest.checkEmail(email: email).urlRequest)
        return try ResponseMapper.map(data: data, response: response)
    }
}
