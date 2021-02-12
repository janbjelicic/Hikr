//
//  LoginViewModel.swift
//  Hikr
//
//  Created by Jan Bjelicic on 31/01/2021.
//

import SwiftUI
import HikrNetworking

class LoginViewModel: ObservableObject {
    
    @Binding private var setupState: AccountSetupState
    
    init(setupState: Binding<AccountSetupState>) {
        self._setupState = setupState
    }
    
    func showRegisterScreen() {
        setupState = .register
    }
    
    func login(email: String, password: String) {
        let authorizationGateway = AuthorizationGateway(networkSession: NetworkSession())
        let login = LoginRequest(email: email, password: password)
        authorizationGateway.login(loginData: login)
    }
    
}
