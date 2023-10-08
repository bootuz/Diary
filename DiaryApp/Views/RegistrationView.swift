//
//  RegistrationView.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 27.09.2023.
//

import SwiftUI


struct RegistrationView: View {
    @Bindable private var viewModel = RegistrationViewModel(service: RegistrationService(client: URLSession.shared))
    @State private var showErrorMessage: Bool = false
    @State private var showCodeView: Bool = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            VStack {
                Text("Sign up".uppercased())
                    .fontWeight(.semibold)
                .font(.largeTitle)
//                Text("Start writing your stories")
//                    .font(.system(size: 20, weight: .regular, design: .rounded))
//                    .foregroundStyle(.secondary)
            }

            VStack {
                LabeledTextField(title: "Login", text: $viewModel.nickname) {
                    Image(systemName: "person")
                }
                .onChange(of: viewModel.nickname) {
                    showErrorMessage = false
                }

                LabeledTextField(title: "Email", text: $viewModel.email) {
                    Image(systemName: "envelope")
                }
                .keyboardType(.emailAddress)
                .onChange(of: viewModel.email) {
                    showErrorMessage = false
                }

                LabeledTextField(title: "Password", text: $viewModel.password, type: .password) {
                    Image(systemName: "lock" )
                }
                .onChange(of: viewModel.password) {
                    showErrorMessage = false
                }
            }
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)

            AsyncButton(action: {
                guard viewModel.validateForms() else { return }
                guard viewModel.isEmailValid(),
                      await viewModel.isNicknameAvailable(),
                      await viewModel.isEmailAvailable()
                else {
                    showErrorMessage = true
                    return
                }
                await viewModel.crateAccount()
                showCodeView.toggle()
            }, label: {
                Text("Create account")
                    .frame(maxWidth: .infinity, maxHeight: 40)
            }, isPerformingTask: $viewModel.isPerformingRequest)
            .navigationDestination(isPresented: $showCodeView, destination: {
                CodeView()
//                    .navigationBarBackButtonHidden(true)
            })
            .alert("Error", isPresented: $viewModel.isAlertPresented, actions: {
                Button("OK", role: .cancel) { }
            }, message: {
                Text(viewModel.errorMessage)
            })
            .buttonStyle(.borderedProminent)
            .padding(.top)

            ErrorLabel(message: viewModel.errorMessage)
                .opacity(showErrorMessage ? 1 : 0)
                .offset(y: 6)

            HStack {
                Text("Already have an account?")
                Button {
                    dismiss()
                } label: {
                    Text("Sign In")
                        .fontWeight(.bold)
                }
            }
            .offset(y: 40)
        }
        .disabled(viewModel.isPerformingRequest)
        .padding(.horizontal)
    }
}

#Preview {
    RegistrationView()
}
