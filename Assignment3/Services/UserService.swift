//
//  UserService.swift
//  Assignment3
//
//  Created by Trung Nguyen on 11/09/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct UserService {
    private static func fromFirebaseDocument(_ docSnapshot: DocumentSnapshot) -> AppUser? {
        let email = docSnapshot.get("email") as? String
        let displayName = docSnapshot.get("displayName") as? String
        let address = docSnapshot.get("address") as? String
        let phone = docSnapshot.get("phone") as? String
        
        guard let email
        else {
            return nil
        }
        
        return AppUser(uid: docSnapshot.documentID,
                       email: email,
                       displayName: displayName,
                       address: address,
                       phone: phone)
    }
    
    static func syncAppUserWithFirebaseUser(firebaseUser: User) {
        var syncData: [String : Any] = [:]
        
        if let email = firebaseUser.email {
            syncData["email"] = email
        }
        
        if let displayName = firebaseUser.displayName {
            syncData["displayName"] = displayName
        }
        
        guard !syncData.isEmpty else {
            return
        }
        
        Firestore.firestore().collection(USERS_COLLECTION_PATH).document(firebaseUser.uid).setData(syncData)
    }
    
    static func createAppUserFromFirebaseUser(firebaseUser: User, extraInfo: UpdateAppUser?) {
        let appUser = AppUser(uid: firebaseUser.uid,
                              email: firebaseUser.email ?? "",
                              displayName: extraInfo?.displayName ?? firebaseUser.displayName,
                              address: extraInfo?.address,
                              phone: extraInfo?.phone ?? firebaseUser.phoneNumber)
        
        Firestore.firestore().collection(USERS_COLLECTION_PATH).document(firebaseUser.uid).setData(appUser.dictionary)
    }
    
    
    
    static func getAppUser(
    uid: String,
    completion: @escaping (_ appUser: AppUser?) -> Void
    ) {
        Firestore.firestore().collection(USERS_COLLECTION_PATH).document(uid).getDocument {
            doc, error in
            guard let userDocument = doc else {
                completion(nil)
                return
            }
            
            completion(Self.fromFirebaseDocument(userDocument))
            
        }
    }
    
    static func update(update: UpdateAppUser) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }

        let changeRequest = currentUser.createProfileChangeRequest()

        if let displayName = update.displayName {
            changeRequest.displayName = displayName
        }

        changeRequest.commitChanges()
        Firestore.firestore().collection(USERS_COLLECTION_PATH).document(currentUser.uid).setData(update.dictionary)
    }
}
