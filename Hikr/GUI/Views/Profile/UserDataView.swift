//
//  UserDataView.swift
//  Hikr
//
//  Created by Jan Bjelicic on 02/02/2021.
//

import SwiftUI
import HikrNetworking

struct UserDataView: View {
    
    @StateObject var viewModel: UserDataViewModel
    
    var body: some View {
        VStack (spacing: 10) {
            firstName
            lastName
            title
            bio
            Spacer()
        }
        .padding()
        .navigationTitle("User information")
    }
    
    private var firstName: some View {
        TextField("Enter first name", text: $viewModel.profile.firstName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }

    private var lastName: some View {
        TextField("Enter last name", text: $viewModel.profile.lastName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }

    // Make a hidden dropdown
    private var title: some View {
        TextField("Title", text: $viewModel.profile.title)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }

    // Multiline
    private var bio: some View {
        TextField("Bio", text: $viewModel.profile.bio)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct UserDataView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDataView(viewModel: UserDataViewModel(profile: .constant(Profile(firstName: "John",
                                                                                 lastName: "Doe",
                                                                                 title: "MR",
                                                                                 bio: "I'm a software developer"))))
        }
    }
}
