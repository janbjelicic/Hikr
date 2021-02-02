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
        VStack(spacing: 10) {
            name
            title
            bio
            Spacer()
        }
        .padding()
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

    // Make a hidden dropdown
    private var title: some View {
        TextField("Title", text: $viewModel.profile.title)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }

    // Multiline
    private var bio: some View {
        TextEditor(text: $viewModel.profile.bio)
            
    }
}

struct UserDataView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDataView(viewModel: UserDataViewModel(profile: .constant(Profile(name: "John",
                                                                                 title: "MR",
                                                                                 bio: "I'm a software developer"))))
        }
    }
}
