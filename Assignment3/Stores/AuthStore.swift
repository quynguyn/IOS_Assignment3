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
import FirebaseFirestore

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
    
    private var userListener: ListenerRegistration?
    
    init() {
        self.handle = Auth.auth().addStateDidChangeListener { auth, user in
            guard let currentUser = user else {
                self.isLoadingAuthState = false
                self.user = nil
                return
            }
            Task.init(priority: .high) {
                await UserService.syncAppUserWithFirebaseUser(firebaseUser: currentUser)
                
                self.userListener?.remove();
                
                self.userListener = UserService.listenToAppUserChange(uid: currentUser.uid, onChange: {
                    appUser in
                    self.isLoadingAuthState = false
                    self.user = appUser
                })
            }
        }
    }
    
    deinit {
        if let handle = self.handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
