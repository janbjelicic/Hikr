//
//  ProfileView.swift
//  Hikr
//
//  Created by Jan Bjelicic on 03/02/2021.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            name
            // Implement settings row item
            // Implement logout row item
            Spacer()
        }
        .navigationTitle(R.string.localizable.profileTitle())
    }
    
    private var name: some View {
        Text("")
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel())
    }
}
