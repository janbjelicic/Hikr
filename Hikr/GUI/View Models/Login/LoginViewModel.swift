//
//  LoginViewModel.swift
//  Hikr
//
//  Created by Jan Bjelicic on 31/01/2021.
//

import Foundation
import HikrNetworking

class LoginViewModel: ObservableObject {
    
    func login(email: String, password: String) {
        let authorizationGateway = AuthorizationGateway(networkSession: NetworkSession())
        let login = Login(email: email, password: password)
        authorizationGateway.login(loginData: login)
    }
    
}
