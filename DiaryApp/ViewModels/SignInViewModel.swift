//
//  SignInViewModel.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 01.10.2023.
//

import Foundation


@Observable
class SignInViewModel: Validator {

    var email: String = ""
    var password: String = ""
    var errorMessage: String = ""
    var showErrorMessage: Bool = false
    var isPerformingRequest: Bool = false

    private var service: TokenProvider

    init(service: TokenProvider) {
        self.service = service
    }


    func validateForms() -> Bool {
        guard !email.isEmpty,
              !password.isEmpty
        else { return false }
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
    func fetchToken(username: String, password: String) async {
        do {
            let response = try await service.fetchToken(with: AuthCreds(username: username, password: password))
            service.setToken(response)
        } catch {
            errorMessage = error.localizedDescription
            showErrorMessage = true
        }
    }
}
