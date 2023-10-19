//
//  CodeView.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 01.10.2023.
//

import SwiftUI
import Combine

struct ActivateAccountView: View {
    @State private var viewModel = ActivateAccountViewModel(service: ActivateAccountService(client: URLSession.shared))
    @FocusState private var focusedField: Bool?

    var body: some View {
        VStack {
            Text("Activate account".uppercased())
                .fontWeight(.semibold)
                .font(.largeTitle)
            
            ZStack {
                TextField("", text: $viewModel.code)
                    .frame(width: 0, height: 35, alignment: .center)
                    .font(.system(size: 0))
                    .focused($focusedField, equals: true)
                    .onReceive(Just(viewModel.code), perform: { _ in
                        viewModel.limit(to: 6)
                    })
                    .onChange(of: viewModel.code) {
                        viewModel.filterOnlyDigits()
                        viewModel.showErrorMessage = false
                    }
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.numberPad)
                    .opacity(0)
                    .padding()

                HStack {
                    ForEach(0..<6) { index in
                        ZStack {
                            Text("\(viewModel.getPin(at: index))")
                                .font(Font.system(size: 27))
                                .fontWeight(.semibold)

                            Rectangle()
                                .frame(height: 2)
                                .foregroundStyle(Color.gray)
                                .opacity(viewModel.code.count <= index ? 1 : 0)
                                .padding(.horizontal, 5)
                        }
                    }
                }
                .padding(.vertical)
                .onTapGesture { focusedField = true }
            }
            .onAppear { focusedField = true }

            AsyncButton(action: {
                guard viewModel.codeIsValid() else { return }
                await viewModel.activateAccount()
            }, label: {
                Text("Activate")
                    .frame(maxWidth: .infinity, maxHeight: 40)
            }, isPerformingTask: $viewModel.isPerformingRequest)
            .buttonStyle(.borderedProminent)
            .padding(.top)

            ErrorLabel(message: viewModel.errorMessage)
                .opacity(viewModel.showErrorMessage ? 1 : 0)
                .offset(y: 6)
        }
        .disabled(false)
        .padding(.horizontal)
    }
}

#Preview {
    ActivateAccountView()
}
