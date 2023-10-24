//
//  AuthTextField.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 28.09.2023.
//

import SwiftUI

enum TextFieldType {
    case regular
    case password
}

struct LabeledTextField<Label: View>: View {
    var title: String
    @Binding var text: String
    var type: TextFieldType = .regular
    @ViewBuilder var label: () -> Label

    var body: some View {
        LabeledContent {
            switch type {
                case .regular:
                    TextField(title, text: $text)
                case .password:
                    SecureField(title, text: $text)
            }
        } label: {
            label()
                .opacity(0.2)
        }
        .labeledContentStyle(RoundedGrayLabeledContentStyle())
    }
}

struct RoundedGrayLabeledContentStyle: LabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        LabeledContent(configuration)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    LabeledTextField(title: "Email", text: .constant("")) {
        Image(systemName: "envelope")
    }
}
