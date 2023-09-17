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
    var user: AppUser?
    
    @Published
    var isLoadingAuthState = true
    
    private var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        self.handle = Auth.auth().addStateDidChangeListener { auth, user in
            guard let currentUser = user else {
                self.isLoadingAuthState = false
                self.user = nil
                return
            }

            UserService.syncAppUserWithFirebaseUser(firebaseUser: currentUser)
            
            UserService.getAppUser(uid: currentUser.uid, completion: {
                appUser in
                self.isLoadingAuthState = false
                if let appUser {
                    self.user = appUser
                }
            })
        }
    }
    
    deinit {
        if let handle = self.handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
