//
//  AuthMockManager.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 10.11.26.
//

import UIKit

class AuthMockManager: AuthManagerUseCase {

    var currentUser: AuthUser? { return nil }

    private func makeUser(email: String?, name: String?) -> AuthUser {
        return AuthUser(uid: "mock-uid", email: email, displayName: name)
    }

    func signIn(email: String, password: String,
                completion: @escaping (AuthUser?, String?) -> Void) {
        completion(makeUser(email: email, name: "Mock User"), nil)
    }

    func createAccount(name: String, email: String, password: String,
                       completion: @escaping (AuthUser?, String?) -> Void) {
        completion(makeUser(email: email, name: name), nil)
    }

    func signInWithGoogle(presenting viewController: UIViewController,
                          completion: @escaping (AuthUser?, String?) -> Void) {
        completion(makeUser(email: "google@mock.com", name: "Google Mock"), nil)
    }

    func signInWithApple(completion: @escaping (AuthUser?, String?) -> Void) {
        completion(makeUser(email: "apple@mock.com", name: "Apple Mock"), nil)
    }

    func sendPasswordReset(email: String, completion: @escaping (String?) -> Void) {
        completion(nil)
    }

    func signOut() -> String? {
        return nil
    }
}
