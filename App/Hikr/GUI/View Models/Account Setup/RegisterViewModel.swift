//
//  RegisterViewModel.swift
//  Hikr
//
//  Created by Jan Bjelicic on 12/02/2021.
//

import SwiftUI

class RegisterViewModel: ObservableObject {
    
    @Binding private var setupState: AccountSetupState
    
    init(setupState: Binding<AccountSetupState>) {
        self._setupState = setupState
    }
    
    func showLoginScreen() {
        setupState = .login
    }
    
}
