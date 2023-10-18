//
//  SignInView.swift
//  DiaryApp
//
//  Created by Астемир Бозиев on 01.10.2023.
//

import SwiftUI

struct SignInView: View {
    @State private var viewModel = SignInViewModel(service: TokenService(client: BasicAuthDecorator(client: URLSession.shared)))

    @State private var isResetPasswordSheetPresented: Bool = false

    var body: some View {
        NavigationStack() {
            VStack {
                Text("Sign In".uppercased())
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

                    LabeledTextField(title: "Password", text: $viewModel.password, type: .password) {
                        Image(systemName: "lock" )
                    }
                    .onChange(of: viewModel.password) {
                        viewModel.showErrorMessage = false
                    }
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                
                HStack {
                    Spacer()
                    Button(action: {
                        isResetPasswordSheetPresented.toggle()
                    }, label: {
                        Text("Forgot password?")
                    })
                    .sheet(isPresented: $isResetPasswordSheetPresented, content: {
                        ResetPasswordInitView(isResetPasswordSheetPresented: $isResetPasswordSheetPresented)
                    })
                }

                AsyncButton(action: {
                    guard viewModel.validateForms() else { return }
                    guard viewModel.isEmailValid() else {
                        viewModel.showErrorMessage = true
                        return
                    }
                    await viewModel.fetchToken(username: viewModel.email, password: viewModel.password)
                }, label: {
                    Text("Sign in")
                        .frame(maxWidth: .infinity, maxHeight: 40)
                }, isPerformingTask: $viewModel.isPerformingRequest)
                .buttonStyle(.borderedProminent)
                .padding(.top)

                ErrorLabel(message: viewModel.errorMessage)
                    .opacity(viewModel.showErrorMessage ? 1 : 0)
                    .offset(y: 6)

                HStack {
                    Text("Don't have an account?")
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Sign Up")
                            .fontWeight(.bold)
                    }
                }
                .offset(y: 40)
            }
            .disabled(viewModel.isPerformingRequest)
            .padding(.horizontal)
        }
    }
}

#Preview {
    SignInView()
}
