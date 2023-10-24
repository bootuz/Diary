//
//  RootTabView.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 21.10.2023.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            DailyRecordsView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Notes")
                }

            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
            
            StreetView()
                .tabItem {
                    Image(systemName: "tree")
                    Text("Street")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    RootTabView()
}
