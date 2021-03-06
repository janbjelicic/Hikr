//
//  RoutesView.swift
//  Hikr
//
//  Created by Jan Bjelicic on 16/02/2021.
//

import SwiftUI

struct RoutesView: View {
    @StateObject var viewModel: RoutesViewModel
    
    var body: some View {
        VStack {
            description
            if viewModel.routes.count == 0 {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.routes) { route in
                            HStack {
                                Text(route.name)
                                Spacer()
                                Button("Download gpx") {
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(title: Text(R.string.localizable.alertErrorTitle()),
                  message: Text(R.string.localizable.alertErrorGeneric()),
                  dismissButton: .default(Text(R.string.localizable.alertCancel())))
        }
        .onAppear {
            viewModel.getRoutes()
        }
        .navigationBarTitle("Routes")
        .navigationBarItems(trailing: Button(action: {
            viewModel.getRoutes(shouldRefresh: true)
        }) {
            Image(systemName: "arrow.clockwise")
        })
    }
    
    private var description: some View {
        Text("List of avaliable hiking routes")
            .padding(.top, 20)
    }
}

struct RoutesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RoutesView(viewModel: RoutesViewModel())
        }
    }
}
