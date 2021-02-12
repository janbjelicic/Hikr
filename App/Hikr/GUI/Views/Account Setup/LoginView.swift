//
//  LoginView.swift
//  Hikr
//
//  Created by Jan Bjelicic on 27/01/2021.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            title
            emailText
            emailField
            passwordText
            passwordField
            login
            register
            Spacer()
        }
        .padding()
    }
    
    private var title: some View {
        Text(R.string.localizable.loginTitle())
            .font(.title)
            .foregroundColor(Color(R.color.primaryColor.name))
            .padding(.bottom, 20)
    }
    
    private var emailText: some View {
        HStack {
            Label(R.string.localizable.loginEmailText(),
                  systemImage: "envelope")
                .font(.callout)
                .foregroundColor(Color(R.color.primaryColor.name))
            Spacer()
        }
    }
    
    private var emailField: some View {
        TextField(R.string.localizable.loginEmailHint(), text: $email)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    private var passwordText: some View {
        HStack {
            Label(R.string.localizable.loginPasswordText(),
                  systemImage: "lock.fill")
                .font(.callout)
                .foregroundColor(Color(R.color.primaryColor.name))
            Spacer()
        }
    }
    
    private var passwordField: some View {
        SecureField(R.string.localizable.loginPasswordHint(), text: $password)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    private var login: some View {
        Button(action: {
            //viewModel.login(email: email, password: password)
        }) {
            Text(R.string.localizable.loginButton())
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color(R.color.primaryColor.name))
                .cornerRadius(10)
        }
    }
    
    private var register: some View {
        HStack {
            Text(R.string.localizable.loginRegisterNoAccount())
            Button(R.string.localizable.loginRegisterButton()) {
                viewModel.showRegisterScreen()
            }
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(setupState: .constant(.login)))
    }
}
