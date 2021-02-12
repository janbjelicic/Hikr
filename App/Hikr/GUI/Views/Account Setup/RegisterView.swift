//
//  RegisterView.swift
//  Hikr
//
//  Created by Jan Bjelicic on 12/02/2021.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @StateObject var viewModel: RegisterViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            title
            emailText
            emailField
            passwordText
            passwordField
            
            register
            login
            Spacer()
            copyright
        }
        .padding()
    }
    
    private var title: some View {
        Text(R.string.localizable.registerTitle())
            .font(.title)
            .foregroundColor(Color(R.color.primaryColor.name))
            .padding(.bottom, 20)
    }
    
    private var emailText: some View {
        HStack {
            Label(R.string.localizable.registerEmailText(),
                  systemImage: "envelope")
                .font(.callout)
                .foregroundColor(Color(R.color.primaryColor.name))
            Spacer()
        }
    }
    
    private var emailField: some View {
        TextField(R.string.localizable.registerEmailHint(), text: $email)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    private var passwordText: some View {
        HStack {
            Label(R.string.localizable.registerPasswordText(),
                  systemImage: "lock.fill")
                .font(.callout)
                .foregroundColor(Color(R.color.primaryColor.name))
            Spacer()
        }
    }
    
    private var passwordField: some View {
        SecureField(R.string.localizable.registerPasswordHint(), text: $password)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    private var register: some View {
        Button(action: {
            //viewModel.login(email: email, password: password)
        }) {
            Text(R.string.localizable.registerButton())
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color(R.color.primaryColor.name))
                .cornerRadius(10)
        }
    }
    
    private var login: some View {
        HStack {
            Text(R.string.localizable.registerLoginAlreadyAUser())
            Button(R.string.localizable.registerLoginButton()) {
                viewModel.showLoginScreen()
            }
        }
    }
    
    private var copyright: some View {
        Text(R.string.localizable.registerCopyright())
            .font(.caption)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: RegisterViewModel(setupState: .constant(.register)))
    }
}
