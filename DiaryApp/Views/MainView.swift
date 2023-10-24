//
//  ContentView.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 24.09.2023.
//

import SwiftUI

struct MainView: View {
    @State var isAuthenticated = AppManager.IsAuthenticated()

    var body: some View {
        ZStack {
            if isAuthenticated {
                RootTabView()
            } else {
                SignInView()
                    .transition(.push(from: .bottom))
            }
        }
        .onReceive(AppManager.Authenticated) { isAuthenticated = $0 }
    }
}

#Preview {
    MainView()
}
