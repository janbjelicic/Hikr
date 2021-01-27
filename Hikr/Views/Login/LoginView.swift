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
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Spacer()
                title
                Spacer()
                emailText
                emailField
                passwordText
                passwordField
                login
                Spacer()
            }
            .padding()
        }
        //.edgesIgnoringSafeArea(.all)
    }
    
    private var title: some View {
        Text("Hikr")
            .font(.title)
            .foregroundColor(Color("primaryColor"))
    }
    
    private var emailText: some View {
        HStack {
            Text("Email")
                .font(.callout)
                .foregroundColor(Color("primaryColor"))
            Spacer()
        }
    }
    
    private var emailField: some View {
        TextField("example@email.com", text: $email)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    private var passwordText: some View {
        HStack {
            Text("Password")
                .font(.callout)
                .foregroundColor(Color("primaryColor"))
            Spacer()
        }
    }
    
    private var passwordField: some View {
        SecureField("", text: $password)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    private var login: some View {
        Button("Login") {
            
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .foregroundColor(.white)
        .background(Color("primaryColor"))
        .cornerRadius(10)
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            
    }
}
