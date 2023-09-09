//
//  AuthStore.swift
//  Assignment3
//
//  Created by Trung Nguyen on 09/09/2023.
//

import Foundation

import GoogleSignIn
import FirebaseCore
import FirebaseAuth

struct RuntimeError: LocalizedError {
    let description: String

    init(_ description: String) {
        self.description = description
    }

    var errorDescription: String? {
        description
    }
}

@MainActor
class AuthStore : ObservableObject {
    @Published
    var user: User?
    
    private var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        self.handle = Auth.auth().addStateDidChangeListener { auth, user in
            self.user = user
        }
    }
    
    deinit {
        if let handle = self.handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func signInWithEmailAndPassword(
        email: String,
        password: String,
        onSuccess: @escaping () -> Void = {},
        onError: @escaping (_ error: any Error) -> Void = {error in }
    ) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
    
            if let authError = error {
                onError(authError)
                return
            }
            
            if authResult != nil {
                onSuccess()
            }
        }
    }
    
    func createUserWithEmailAndPassword(
        email: String,
        password: String,
        onSuccess: @escaping () -> Void = {},
        onError: @escaping (_ error: any Error) -> Void = {error in }
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let createUserError = error {
                onError(createUserError)
                return
            }
            
            if authResult != nil {
                onSuccess()
            }
        }
    }
    
    func signOut(
        onSuccess: @escaping () -> Void = {},
        onError: @escaping (_ error: any Error) -> Void = {error in }
    ) {
        guard let _ = self.user else {
            return
        }
        
        do {
            try Auth.auth().signOut()
            onSuccess()
        } catch let signOutError as NSError {
            onError(signOutError)
        }
    }
    
    private func signInWithCredential(googleUser: GIDGoogleUser,
                                      onSuccess: @escaping () -> Void = {},
                                      onError: @escaping (_ error: any Error) -> Void = {error in }) {
        guard let idToken = googleUser.idToken?.tokenString else {
            onError(RuntimeError("ID token not found"))
            return;
        }
            
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                     accessToken: googleUser.accessToken.tokenString)
        
        Auth.auth().signIn(with: credential) { result, error in
            if let signInError = error {
                onError(signInError)
                return
            }
            
            if result != nil {
                onSuccess()
            }
          
        }
        
    }

    // https://firebase.google.com/docs/auth/ios/google-signin
    func signInWithGoogle(
        onSuccess: @escaping () -> Void = {},
        onError: @escaping (_ error: any Error) -> Void = {error in }
    ) {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { googleUser, error in
                if let signInError = error {
                    onError(signInError)
                    return
                }
                
                guard let googleUser else {
                    onError(RuntimeError("User not found"))
                    return;
                }
                
                self.signInWithCredential(googleUser: googleUser)
            }
            
            return;
        }
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            
            if let signInError = error {
                onError(signInError)
                return
            }
          

            guard let googleUser = result?.user else {
                onError(RuntimeError("User not found"))
                return
            }

            self.signInWithCredential(googleUser: googleUser)
        }
      
    }
}
