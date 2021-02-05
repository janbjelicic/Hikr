//
//  UserDataView.swift
//  Hikr
//
//  Created by Jan Bjelicic on 02/02/2021.
//

import SwiftUI

struct UserDataView: View {
    
    @StateObject var viewModel: UserDataViewModel
    
    var body: some View {
        Form { // Decide hoow yoou want to display the form and if you want to use it
            VStack(spacing: 10) {
                name
                address
                phoneNumber
                bio
                Spacer()
                save
            }
        }
        .navigationTitle("User information")
    }
    
    private var name: some View {
        VStack {
            HStack {
                Label("Name", systemImage: "person.fill")
                Spacer()
            }
            TextField("Enter name", text: $viewModel.profile.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    
    private var address: some View {
        VStack {
            HStack {
                Label("Address", systemImage: "building.fill")
                Spacer()
            }
            TextField("Enter address", text: $viewModel.profile.address)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    
    private var phoneNumber: some View {
        VStack {
            HStack {
                Label("Phone number", systemImage: "phone.fill")
                Spacer()
            }
            TextField("Enter phone numbeer", text: $viewModel.profile.phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }

    private var bio: some View {
        VStack {
            HStack {
                Label("Information", systemImage: "book.fill")
                Spacer()
            }
            TextEditor(text: $viewModel.profile.bio)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    
    private var save: some View {
        Button(action: {
            //viewModel.login(email: email, password: password)
        }) {
            Text("Save")
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color(R.color.primaryColor.name))
                .cornerRadius(10)
        }
    }
}

struct UserDataView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDataView(viewModel: UserDataViewModel(profile: .constant(Profile.example)))
        }
    }
}
