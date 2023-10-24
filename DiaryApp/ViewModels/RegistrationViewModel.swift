//
//  RegistrationViewModel.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 27.09.2023.
//

import Foundation

protocol Validator {
    var email: String { get set }
    func validateEmail() -> Bool
    func validateForms() -> Bool
}

extension Validator {
    func validateEmail() -> Bool {
        let regExMatchEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicateEmail = NSPredicate(format: "SELF MATCHES %@", regExMatchEmail)
        return predicateEmail.evaluate(with: email)
    }
}

@Observable
class RegistrationViewModel: Validator {

    var nickname: String = ""
    var email: String = ""
    var password: String = ""
    var errorMessage: String = ""
    var isPerformingRequest: Bool = false

    private var service: RegistrationProtocol

    init(service: RegistrationProtocol) {
        self.service = service
    }

    @MainActor
    func crateAccount() async {
        let account = CreateAccountDTO(email: self.email, nickname: self.nickname, password: self.password)
        do {
            let _ = try await service.createAccount(data: account)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    @MainActor
    func isEmailAvailable() async -> Bool {
        do {
            let response = try await service.checkEmail(email: email)
            guard let isAvailable = response.body else {
                errorMessage = "Response error"
                return false
            }
            errorMessage = isAvailable ? "" : "Email is not available"
            return isAvailable
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    @MainActor
    func isNicknameAvailable() async -> Bool {
        do {
            let response = try await service.checkNickname(nickName: nickname)
            guard let isAvailable = response.body else {
                errorMessage = "Response error"
                return false
            }
            errorMessage = isAvailable ? "" : "Nickname is not available"
            return isAvailable
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func validateForms() -> Bool {
        guard !email.isEmpty,
              !nickname.isEmpty,
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
}
