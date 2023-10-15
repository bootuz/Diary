//
//  ResetPasswordViewModel.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 07.10.2023.
//

import Foundation


@Observable
class UpdatePasswordViewModel {

    var codeFromEmail: String = ""
    var newPassword: String = ""
    var errorMessage: String = ""
    var showErrorMessage: Bool = false
    var isPerformingRequest: Bool = false

    private var service: UpdatePasswordProtocol

    init(service: UpdatePasswordProtocol) {
        self.service = service
    }

    func validateForms() -> Bool {
        guard !codeFromEmail.isEmpty,
              !newPassword.isEmpty
        else { return false }
        return true
    }
    
    @MainActor
    func updatePassword() async {
        let resetPassword = UpdatePasswordDTO(codeFromEmail: codeFromEmail, newPassword: newPassword)
        do {
            let _ = try await service.updatePassword(data: resetPassword)
        } catch {
            errorMessage = error.localizedDescription
            showErrorMessage = true
        }
    }
}
