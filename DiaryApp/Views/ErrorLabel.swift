//
//  ErrorLabel.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 07.10.2023.
//

import SwiftUI


struct ErrorLabel: View {
    var message: String
    var body: some View {
        HStack {
            Text("Whoops!")
                .fontWeight(.bold)
            Text(message)
        }
        .foregroundStyle(.red)
    }
}

#Preview {
    ErrorLabel(message: "Error")
}
