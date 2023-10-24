//
//  MyNotesViewModel.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 22.10.2023.
//

import Foundation

@Observable
class DailyRecordsViewModel {
    
    var currentDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: Date())
    }

    var dailyRecords: DailyRecordDTO?
    var errorMessage: String = ""

    private var service: DailyRecordsService

    init(service: DailyRecordsService) {
        self.service = service
    }

    @MainActor
    func getDailyRecords(date: String = "") async {
        do {
            let response = try await service.getDailyRecords(date: date)
            dailyRecords = response.body
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
