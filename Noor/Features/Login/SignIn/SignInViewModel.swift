//
//  SignInViewModel.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 06.11.26.
//

import Foundation

class SignInViewModel {

    var email = ""
    var password = ""

    var isEmailValid: Bool {
        return email.contains("@") && email.contains(".")
    }

    var isPasswordValid: Bool {
        return password.count >= 8
    }

    var canSignIn: Bool {
        return isEmailValid && isPasswordValid
    }
}
