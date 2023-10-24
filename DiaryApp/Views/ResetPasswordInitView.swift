//
//  ResetPasswordView.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 07.10.2023.
//

import SwiftUI

struct ResetPasswordInitView: View {
    @Binding var isResetPasswordSheetPresented: Bool
    @State private var viewModel = ResetPasswordInitViewModel(service: ResetPasswordInitService(client: URLSession.shared))

    var body: some View {
        NavigationStack() {
            VStack {
                Text("Reset password".uppercased())
                    .fontWeight(.semibold)
                    .font(.largeTitle)

                VStack {
                    LabeledTextField(title: "Email", text: $viewModel.email) {
                        Image(systemName: "envelope")
                    }
                    .keyboardType(.emailAddress)
                    .onChange(of: viewModel.email) {
                        viewModel.showErrorMessage = false
                    }
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

                AsyncButton(action: {
                    guard viewModel.validateForms() else { return }
                    guard viewModel.isEmailValid() else {
                        viewModel.showErrorMessage = true
                        return
                    }
                    await viewModel.resetPasswordInit()
                }, label: {
                    Text("Reset")
                        .frame(maxWidth: .infinity, maxHeight: 40)
                }, isPerformingTask: $viewModel.isPerformingRequest)
                .buttonStyle(.borderedProminent)
                .padding(.top)
                .navigationDestination(isPresented: $viewModel.showUpdatePasswordView) {
                    UpdatePasswordView(isResetPasswordSheetPresented: $isResetPasswordSheetPresented)
                }
                
                ErrorLabel(message: viewModel.errorMessage)
                    .opacity(viewModel.showErrorMessage ? 1 : 0)
                    .offset(y: 6)
            }
            .disabled(viewModel.isPerformingRequest)
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isResetPasswordSheetPresented = false
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.gray)
                    })
                }
            }
        }
    }
}

#Preview {
    ResetPasswordInitView(isResetPasswordSheetPresented: .constant(true))
}
