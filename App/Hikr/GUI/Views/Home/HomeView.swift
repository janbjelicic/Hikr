//
//  HomeView.swift
//  Hikr
//
//  Created by Jan Bjelicic on 12/02/2021.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                        .foregroundColor(Color(R.color.primaryColor.name))
                }
            NavigationView {
                RoutesView(viewModel: RoutesViewModel())
            }
            .tabItem {
                Label("Routes", systemImage: "folder.fill")
                    .foregroundColor(Color(R.color.primaryColor.name))
            }
            ProfileView(viewModel: ProfileViewModel())
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                        .foregroundColor(Color(R.color.primaryColor.name))
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
