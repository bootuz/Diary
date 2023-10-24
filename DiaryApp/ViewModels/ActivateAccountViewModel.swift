//
//  CodeViewModel.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 16.10.2023.
//

import Foundation

@Observable
class ActivateAccountViewModel {
    var code: String = ""
    var errorMessage: String = ""
    var showErrorMessage: Bool = false
    var isPerformingRequest: Bool = false

    private var service: ActivateAccountProtocol

    init(service: ActivateAccountProtocol) {
        self.service = service
    }

    private func filterOnlyDigits(_ text: String) -> String {
        return text.filter { "0123456789".contains($0) }
    }

    func codeIsValid() -> Bool {
        return code.count == 6 && code.allSatisfy { $0.isNumber }
    }

    func getPin(at offset: Int) -> String {
        guard self.code.count > offset else {
            return ""
        }
        let index = code.index(code.startIndex, offsetBy: offset)
        return String(code[index])
    }

    func limit(to limit: Int) {
        code = String(code.prefix(limit))
    }

    func filterOnlyDigits() {
        code = code.filter { "0123456789".contains($0) }
    }
    
    @MainActor
    func activateAccount() async {
        do {
            let _ = try await service.activateAccount(code: code)
        } catch {
            errorMessage = error.localizedDescription
            showErrorMessage = true
        }
    }
}
