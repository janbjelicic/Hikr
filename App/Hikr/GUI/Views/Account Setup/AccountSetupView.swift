//
//  AccountSetupView.swift
//  Hikr
//
//  Created by Jan Bjelicic on 12/02/2021.
//

import SwiftUI

enum AccountSetupState {
    case login
    case register
}

/// Shows either the login or register view
struct AccountSetupView: View {
    
    @State var state: AccountSetupState
    
    var body: some View {
        switch $state.wrappedValue {
        case .register:
            RegisterView(viewModel: RegisterViewModel(setupState: $state))
        case .login:
            LoginView(viewModel: LoginViewModel(setupState: $state))
        }
    }
}

struct AccountSetupView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSetupView(state: .register)
    }
}
