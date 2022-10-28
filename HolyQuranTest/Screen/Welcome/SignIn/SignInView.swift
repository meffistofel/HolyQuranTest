//
//  SignInView.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 27.10.2022.
//  
//

import SwiftUI
import Combine
import AuthenticationServices
import GoogleSignInSwift


// MARK: - SignInView

struct SignInView: View {

    // MARK: - Wrapped Properties

    @Environment(\.container) private var container: DependencyContainer
    @ObservedObject private var viewModel: SignInVM
    @State private var routingState: Routing = .init()

    // MARK: - Properties

    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: container.appState, \.routing.singIn)
    }

    // MARK: - Init

    init(viewModel: SignInVM) {
        self.viewModel = viewModel
    }

    // MARK: - body View

    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 108)
            Image(Constants.Image.imageSiginInLogo)
                .padding(.bottom, 24)
            CustomText(text: "Increase Your Spirituality", font: (.bold, 20), foregroundColor: .black)
                .padding(.bottom, 16)
            CustomText(text: "Log in to save and synchronize your bookmarked verses and comments across all your devices.", font: (.regular, 14), foregroundColor: .gray)
                .multilineTextAlignment(.center)
                .padding(.bottom, 24)
                .padding(.horizontal, 8)
         
            
            Text("We respect your privacy. Check out our Policy")
                .customFont(.semibold, size: 12)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 32)
        .routing(routingBinding: routingBinding.state, with: [.none])
        .navigationBarTitleDisplayMode(.inline)
        .onReceive(routingUpdate) { self.routingState = $0 }
    }
}

// MARK: - ViewBuilder View

private extension SignInView {

    
}

// MARK: - Side Effects

private extension SignInView {
    
    // Apple Sign In
    func onRequest(_ request: ASAuthorizationAppleIDRequest) {
//        viewModel.onRequest(request)
    }

    func onCompletion(_ result: Result<ASAuthorization, Error>) {
//        viewModel.onCompletion(result)
    }

    func logout(with social: Constants.KeychainType) {
//        viewModel.logOut(with: social)
    }
    
    //Google Sign In
    func handleSignInButton() {
        
    }
}

// MARK: - State Updates

private extension SignInView {

}

// MARK: - Routing

extension SignInView {
    struct Routing: Equatable {
        var state: NavigationState?
    }

    var routingUpdate: AnyPublisher<Routing, Never> {
        container.appState.updates(for: \.routing.singIn)
    }
}

// MARK: - Previews

#if DEBUG
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: .preview)
    }
}
#endif
