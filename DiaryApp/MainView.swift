//
//  ContentView.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.09.2023.
//

import SwiftUI


struct MainView: View {
    private var viewModel = AppStateViewModel(service: TokenService(client: URLSession.shared))

    var body: some View {
        switch viewModel.authenticationState {
            case .undefined, .loggedOut:
                SignInView()
            case .loggedIn:
                Text("Main View")
        }
    }
}

#Preview {
    MainView()
}
