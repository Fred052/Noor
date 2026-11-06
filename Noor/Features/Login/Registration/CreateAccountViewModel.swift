//
//  CreateAccountViewModel.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 06.11.26.
//

import Foundation

class CreateAccountViewModel {
    
    var name = ""
    var email = ""
    var password = ""
    
    var isNameValid: Bool {
        return !name.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var isEmailValid: Bool {
        return email.contains("@") && email.contains(".")
    }
    
    var isPasswordValid: Bool {
        return password.count >= 8
    }
    
    var canCreateAccount: Bool {
        return isNameValid && isEmailValid && isPasswordValid
    }
    
}
