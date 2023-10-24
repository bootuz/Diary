//
//  AppStateViewModel.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 18.10.2023.
//

import Foundation
import Combine

struct AppManager {
    static let Authenticated = PassthroughSubject<Bool, Never>()
    
    static func IsAuthenticated() -> Bool {
        return UserDefaults.standard.value(forKey: Constants.tokenKey) != nil
    }

    static func logout() {
        UserDefaults.standard.removeObject(forKey: Constants.tokenKey)
        AppManager.Authenticated.send(false)
    }
}
