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
import Firebase
import FirebaseFirestore
import LocalAuthentication

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


    static func updateUserProfile(
        userId: String, // The user's unique identifier in Firestore
        updatedName: String?,
        updatedAddress: String?,
        updatedPhone: String?,
        onSuccess: @escaping () -> Void = {},
        onError: @escaping (_ error: Error) -> Void = { error in }
    ) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userId)
        
        var updatedData: [String: Any] = [:]
        
        if let newName = updatedName {
            updatedData["displayName"] = newName
        }
        
        if let newAddress = updatedAddress {
            updatedData["address"] = newAddress
        }
        
        if let newPhone = updatedPhone {
            updatedData["phone"] = newPhone
        }
        
        userRef.updateData(updatedData) { error in
            if let updateError = error {
                onError(updateError)
            } else {
                onSuccess()
            }
        }
    }
    
    // https://www.hackingwithswift.com/books/ios-swiftui/using-touch-id-and-face-id-with-swiftui
    static func bioAuthenticate(
        onSuccess: @escaping () -> Void = {},
        onError: @escaping (_ error: Error) -> Void = { error in }
    ) {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to make sure that you are making the order."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    onSuccess();
                    return;
                }
                
                if let authenticationError {
                    onError(authenticationError)
                    return
                }
                
                onError(RuntimeError("Unable to authenticate. Unknown error"))
            }
        } else {
            onError(RuntimeError("Unable to authenticate. No biometrics allowed"))
        }
    }

}

