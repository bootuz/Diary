//
//  AppStateViewModel.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 18.10.2023.
//

import Foundation

// TODO: - WIP the logic is not complete and needs to be reworked.

enum AuthenticationState {
    case undefined, loggedIn, loggedOut
}

@Observable
class AppStateViewModel {
    private var service: TokenProvider

    init(service: TokenProvider) {
        self.service = service
    }
}
