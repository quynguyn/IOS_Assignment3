//
//  AuthService.swift
//  Assignment3
//
//  Created by Trung Nguyen on 09/09/2023.
//

import Foundation

import GoogleSignIn
import FirebaseCore
import FirebaseAuth

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

struct AuthService {
    static func signInWithEmailAndPassword(
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

    static func createUserWithEmailAndPassword(
        email: String,
        password: String,
        phone: String?,
        address: String?,
        name: String?,
        onSuccess: @escaping () -> Void = {},
        onError: @escaping (_ error: any Error) -> Void = {error in }
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let createUserError = error {
                onError(createUserError)
                return
            }
            
            if let authResult {
                let extraInfo = UpdateAppUser(displayName: name,
                                              address: address,
                                              phone: phone)
                UserService.createAppUserFromFirebaseUser(firebaseUser: authResult.user, extraInfo: extraInfo)
                onSuccess()
            }
        }
    }

    static func signOut(
        onSuccess: @escaping () -> Void = {},
        onError: @escaping (_ error: any Error) -> Void = {error in }
    ) {
        do {
            try Auth.auth().signOut()
            onSuccess()
        } catch let signOutError as NSError {
            onError(signOutError)
        }
    }

    // https://firebase.google.com/docs/auth/ios/google-signin
    static func signInWithGoogle(
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
                
                signInWithCredential(googleUser: googleUser)
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

            signInWithCredential(googleUser: googleUser)
        }
      
    }

}

