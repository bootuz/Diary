//
//  ResetPasswordView.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 07.10.2023.
//

import SwiftUI

struct UpdatePasswordView: View {
    @Binding var isResetPasswordSheetPresented: Bool
    @Bindable private var viewModel = UpdatePasswordViewModel(service: UpdatePasswordService(client: URLSession.shared))
    
    var body: some View {
        VStack {
            VStack {
                Text("Update password".uppercased())
                    .fontWeight(.semibold)
                    .font(.largeTitle)
            }

            VStack {
                LabeledTextField(title: "Code from email", text: $viewModel.codeFromEmail) {
                    Image(systemName: "envelope.badge.shield.half.filled")
                }
                .keyboardType(.numberPad)
                .onChange(of: viewModel.codeFromEmail) {
                    viewModel.showErrorMessage = false
                }

                LabeledTextField(title: "New password", text: $viewModel.newPassword, type: .password) {
                    Image(systemName: "lock")
                }
                .keyboardType(.numberPad)
                .onChange(of: viewModel.codeFromEmail) {
                    viewModel.showErrorMessage = false
                }
            }
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)

            AsyncButton(action: {
                guard viewModel.validateForms() else { return }
                await viewModel.updatePassword()
                isResetPasswordSheetPresented = false
            }, label: {
                Text("Update")
                    .frame(maxWidth: .infinity, maxHeight: 40)
            }, isPerformingTask: $viewModel.isPerformingRequest)
            .buttonStyle(.borderedProminent)
            .padding(.top)

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

#Preview {
    UpdatePasswordView(isResetPasswordSheetPresented: .constant(true))
}
