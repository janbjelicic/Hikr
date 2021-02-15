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
                        
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
