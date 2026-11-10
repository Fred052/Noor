//
//  AuthManagerUseCase.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 10.11.26.
//

import UIKit

protocol AuthManagerUseCase {
    var currentUser: AuthUser? { get }

    func signIn(email: String, password: String,
                completion: @escaping (AuthUser?, String?) -> Void)

    func createAccount(name: String, email: String, password: String,
                       completion: @escaping (AuthUser?, String?) -> Void)

    func signInWithGoogle(presenting viewController: UIViewController,
                          completion: @escaping (AuthUser?, String?) -> Void)

    func signInWithApple(completion: @escaping (AuthUser?, String?) -> Void)

    func sendPasswordReset(email: String, completion: @escaping (String?) -> Void)

    func signOut() -> String?
}
