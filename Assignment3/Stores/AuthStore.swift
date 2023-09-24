/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author:
 Nguyen Quoc Hoang Trung - s3818328
 Vu Nguyet Minh - s3878520
 Pham Duy Anh - s3802674
 Nguyen Minh Hien - s3877996
 Nguyen Van Quy - s3878636
 Created  date: 8/9/2023
 Last modified: 23/9/2023
  Acknowledgement:
    “Full-text search | firestore | Firebase,” Google, https://firebase.google.com/docs/firestore/solutions/search?provider=algolia (accessed Sep. 21, 2023).
*/

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
