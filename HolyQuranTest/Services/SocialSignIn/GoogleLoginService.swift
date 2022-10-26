//
//  GoogleLoginService.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 03.10.2022.
//

import Firebase
import GoogleSignIn

class GoogleLoginService {

    enum SignInState {
        case signedIn
        case signedOut
    }

    @Published var state: SignInState = .signedOut

    private let appState: Store<AppState>

    init(appState: Store<AppState>) {
        self.appState = appState
    }


    func signIn() {

        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticateUser(for: user, with: error)
            }
        } else {

            guard let clientID = FirebaseApp.app()?.options.clientID else {
                return
            }

            let configuration = GIDConfiguration(clientID: clientID)

            guard let rootViewController = UIApplication.rootVC() else {
                return
            }

            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
                authenticateUser(for: user, with: error)
            }
        }
    }

    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {

        if let error {
            print(error.localizedDescription)
            return
        }

        guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }

        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)

        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                updateSignInState(isLogin: true, userID: idToken)
                self.state = .signedIn
            }
        }
    }

    func signOut() {
        // 1
        GIDSignIn.sharedInstance.signOut()

        do {
            // 2
            try Auth.auth().signOut()
            updateSignInState(isLogin: false, userID: "")
            state = .signedOut
        } catch {
            print(error.localizedDescription)
        }
    }


}

extension GoogleLoginService {
    private func updateSignInState(isLogin: Bool, userID: String) {
        let socialSignIn = AppState.SocialSignIn(userID: userID, isLogin: isLogin)

        appState[\.socialSignIn] = socialSignIn
        isLogin ? saveUserInKeychain(keychainType: .google, userID) : logOut(with: .google)
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
