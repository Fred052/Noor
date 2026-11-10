//
//  SignInViewModel.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 06.11.26.
//

import UIKit

final class SignInViewModel {

    private let manager: AuthManagerUseCase

    var email = ""
    var password = ""

    var success: (() -> Void)?
    var error: ((String) -> Void)?
    var passwordResetSent: (() -> Void)?

    init(manager: AuthManagerUseCase) {
        self.manager = manager
    }

    var isEmailValid: Bool {
        return email.contains("@") && email.contains(".")
    }

    var isPasswordValid: Bool {
        return password.count >= 8
    }

    var canSignIn: Bool {
        return isEmailValid && isPasswordValid
    }

    func signIn() {
        guard canSignIn else {
            error?("Enter a valid email and a password with at least 8 characters.")
            return
        }
        manager.signIn(email: email, password: password) { [weak self] user, errorMessage in
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

    func resetPassword() {
        guard isEmailValid else {
            error?("Enter your email address first.")
            return
        }
        manager.sendPasswordReset(email: email) { [weak self] errorMessage in
            if let errorMessage {
                self?.error?(errorMessage)
            } else {
                self?.passwordResetSent?()
            }
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
