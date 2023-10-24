//
//  DailyRecordsService.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 22.10.2023.
//

import Foundation

class DailyRecordsService {

    private var client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }
    
    func getDailyRecords(date: String) async throws -> Response<DailyRecordDTO> {
        let (data, response) = try await client.perform(request: DailyRecordsRequest.dailyRecords(date: date).urlRequest)
        return try ResponseMapper.map(data: data, response: response)
    }
}
