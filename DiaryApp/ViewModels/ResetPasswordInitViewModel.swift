//
//  ResetPasswordViewModel.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 07.10.2023.
//

import Foundation

@Observable
class ResetPasswordInitViewModel: Validator {

    var email: String = ""
    var errorMessage: String = ""
    var showErrorMessage: Bool = false
    var isPerformingRequest: Bool = false
    var showUpdatePasswordView: Bool = false

    private var service: ResetPasswordInitProtocol

    init(service: ResetPasswordInitProtocol) {
        self.service = service
    }

    func validateForms() -> Bool {
        guard !email.isEmpty else { return false }
        return true
    }

    func isEmailValid() -> Bool {
        guard validateEmail() else {
            errorMessage = "Email is not valid"
            return false
        }
        return true
    }
    
    @MainActor
    func resetPasswordInit() async {
        do {
            let _ = try await service.resetPasswordInit(email: email)
            showUpdatePasswordView = true
        } catch {
            errorMessage = error.localizedDescription
            showErrorMessage = true
        }
    }
}
