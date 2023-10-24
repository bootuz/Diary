//
//  AsuncButton.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 27.09.2023.
//

import SwiftUI

struct AsyncButton<Label: View>: View {
    var action: () async -> Void
    @ViewBuilder var label: () -> Label

    @Binding private var isPerformingTask: Bool

    init(action: @escaping () async -> Void, label: @escaping () -> Label, isPerformingTask: Binding<Bool>) {
        self.action = action
        self.label = label
        self._isPerformingTask = isPerformingTask
    }

    var body: some View {
        Button(action: {
                isPerformingTask = true

                Task {
                    await action()
                    isPerformingTask = false
                }
            }, label: {
                ZStack {
                    label().opacity(isPerformingTask ? 0 : 1)
                    ProgressView()
                        .controlSize(.regular)
                        .opacity(isPerformingTask ? 1 : 0)
                }
            }
        )
        .disabled(isPerformingTask)
    }
}
