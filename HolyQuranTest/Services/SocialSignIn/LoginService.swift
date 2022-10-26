//
//  SignInWithApple.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 24.08.2022.
//

import Foundation
import SwiftUI
import AuthenticationServices

class LoginService {

    // MARK: - Properties
    private let appState: Store<AppState>

    init(appState: Store<AppState>) {
        self.appState = appState
//        onAppear()
    }
}

// MARK: - Apple sign in with default appleSignIn Button

extension LoginService {
    func onRequest(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }

    func onCompletion(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authResults):
            guard let credential = authResults.credential as? ASAuthorizationAppleIDCredential else {
                return
            }

//            let userName = credential.fullName?.givenName ?? ""
//            let userEmail = credential.email ?? ""
            let userID = credential.user

            updateSignInState(isLogin: true, userID: userID)
        case .failure(let error):
            Log.error("Authorization with Apple Sign In failed: " + error.localizedDescription)
            updateSignInState(isLogin: false, userID: "")
        }
    }

    func onAppear() {
        let userID: String = Keychain.currentUserIdentifier(type: .appleId)

        ASAuthorizationAppleIDProvider()
            .getCredentialState(forUserID: userID) { [weak self] state, _ in
                guard let self, case .authorized = state else {
                    return
                }

                self.updateSignInState(isLogin: true, userID: userID)
            }
    }
}

extension LoginService {
    func updateSignInState(isLogin: Bool, userID: String) {
        let socialSignIn = AppState.SocialSignIn(userID: userID, isLogin: isLogin)

        appState[\.socialSignIn] = socialSignIn
        isLogin ? saveUserInKeychain(keychainType: .facebook, userID) : logOut(with: .facebook)
    }

    private func saveUserInKeychain(keychainType: Constants.KeychainType, _ userIdentifier: String) {
        do {
            try Keychain(keychainType: keychainType).saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }

    private func logOut(with social: Constants.KeychainType) {
        guard Keychain.deleteUserIdentifierFromKeychain(type: social) else {
            return
        }
        appState[\.socialSignIn].logout()
    }
}
