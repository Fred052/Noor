//
//  CreateAccountViewModel.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 06.11.26.
//

import UIKit

final class CreateAccountViewModel {

    private let manager: AuthManagerUseCase

    var name = ""
    var email = ""
    var password = ""

    var success: (() -> Void)?
    var error: ((String) -> Void)?

    init(manager: AuthManagerUseCase) {
        self.manager = manager
    }

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

    func createAccount() {
        guard canCreateAccount else {
            error?("Enter your name, a valid email and a password with at least 8 characters.")
            return
        }
        manager.createAccount(name: name, email: email, password: password) { [weak self] user, errorMessage in
            self?.handle(user: user, errorMessage: errorMessage)
        }
    }

    func signInWithGoogle(presenting viewController: UIViewController) {
        manager.signInWithGoogle(presenting: viewController) { [weak self] user, errorMessage in
            self?.handle(user: user, errorMessage: errorMessage)
        }
    }

    func signInWithApple() {
        manager.signInWithApple { [weak self] user, errorMessage in
            self?.handle(user: user, errorMessage: errorMessage)
        }
    }

    private func handle(user: AuthUser?, errorMessage: String?) {
        if let errorMessage {
            error?(errorMessage)
        } else if user != nil {
            success?()
        }
    }
}
