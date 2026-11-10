//
//  AuthManager.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 10.11.26.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import AuthenticationServices
import CryptoKit

class AuthManager: NSObject, AuthManagerUseCase {

    private var currentNonce: String?
    private var appleCompletion: ((AuthUser?, String?) -> Void)?

    var currentUser: AuthUser? {
        guard let user = Auth.auth().currentUser else { return nil }
        return makeAuthUser(from: user)
    }

    //MARK: - Email ile giris
    func signIn(email: String, password: String,
                completion: @escaping (AuthUser?, String?) -> Void) {
        Auth.auth().signIn(
            withEmail: email,
            password: password
        ) { [weak self] result, error in
            self?.handle(
                user: result?.user,
                error: error,
                completion: completion
            )
        }
    }

    func createAccount(name: String, email: String, password: String,
                       completion: @escaping (AuthUser?, String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error {
                completion(nil, error.localizedDescription)
                return
            }
            guard let user = result?.user else {
                completion(nil, "Account could not be created.")
                return
            }
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges { error in
                self?.handle(user: user, error: error, completion: completion)
            }
        }
    }

    func sendPasswordReset(email: String, completion: @escaping (String?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error?.localizedDescription)
        }
    }

    func signOut() -> String? {
        do {
            try Auth.auth().signOut()
            KeychainManager.shared.delete(KeychainKey.userID)
            KeychainManager.shared.delete(KeychainKey.appleUserID)
            return nil
        } catch {
            return error.localizedDescription
        }
    }

    //MARK: - Google ile giris
    func signInWithGoogle(presenting viewController: UIViewController,
                          completion: @escaping (AuthUser?, String?) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(nil, "Google configuration was not found.")
            return
        }
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { [weak self] result, error in
            if let error {
                completion(nil, error.localizedDescription)
                return
            }
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                completion(nil, "Google sign in failed.")
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result, error in
                self?.handle(user: result?.user, error: error, completion: completion)
            }
        }
    }

    //MARK: - Apple ile giris
    func signInWithApple(completion: @escaping (AuthUser?, String?) -> Void) {
        appleCompletion = completion
        let nonce = randomNonceString()
        currentNonce = nonce

        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

    //MARK: - Helpers
    private func handle(user: User?, error: Error?,
                        completion: (AuthUser?, String?) -> Void) {
        if let error {
            completion(nil, error.localizedDescription)
        } else if let user {
            let authUser = makeAuthUser(from: user)
            KeychainManager.shared.save(authUser.uid, for: KeychainKey.userID)
            completion(authUser, nil)
        } else {
            completion(nil, "Something went wrong. Please try again.")
        }
    }

    private func makeAuthUser(from user: User) -> AuthUser {
        return AuthUser(
            uid: user.uid,
            email: user.email,
            displayName: user.displayName
        )
    }

    private func randomNonceString(length: Int = 32) -> String {
        let charset = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remaining = length

        while remaining > 0 {
            var randoms = [UInt8](repeating: 0, count: 16)
            let status = SecRandomCopyBytes(kSecRandomDefault, randoms.count, &randoms)
            if status != errSecSuccess { return UUID().uuidString }

            for random in randoms where remaining > 0 && random < charset.count {
                result.append(charset[Int(random)])
                remaining -= 1
            }
        }
        return result
    }

    private func sha256(_ input: String) -> String {
        let hashed = SHA256.hash(data: Data(input.utf8))
        return hashed.map { String(format: "%02x", $0) }.joined()
    }
}

extension AuthManager: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {

    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let completion = appleCompletion else { return }
        guard let appleCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let nonce = currentNonce,
              let tokenData = appleCredential.identityToken,
              let idToken = String(data: tokenData, encoding: .utf8) else {
            completion(nil, "Apple sign in failed.")
            return
        }

        KeychainManager.shared.save(appleCredential.user, for: KeychainKey.appleUserID)

        let credential = OAuthProvider.appleCredential(withIDToken: idToken,
                                                       rawNonce: nonce,
                                                       fullName: appleCredential.fullName)
        Auth.auth().signIn(with: credential) { [weak self] result, error in
            self?.handle(user: result?.user, error: error, completion: completion)
            self?.appleCompletion = nil
        }
    }

    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithError error: Error) {
        appleCompletion?(nil, error.localizedDescription)
        appleCompletion = nil
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
        let windows = scenes.flatMap { $0.windows }
        return windows.first(where: { $0.isKeyWindow }) ?? ASPresentationAnchor()
    }
}
