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
import FirebaseAuth
import FirebaseFirestore

struct UserService : FirebaseService {
    typealias GetType = AppUser
    
    typealias CreateType = CreateAppUser
    
    typealias UpdateType = UpdateAppUser
    
    static func fromFirebaseDocument(_ docSnapshot: DocumentSnapshot) -> AppUser? {
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
    
    static func create(_ dto: CreateAppUser, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        Firestore.firestore().collection(USERS_COLLECTION_PATH).document(dto.uid).setData(dto.dictionary)
    }
    
    static func update(id: String, _ dto: UpdateAppUser, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let changeRequest = currentUser.createProfileChangeRequest()

        if let displayName = dto.displayName {
            changeRequest.displayName = displayName
        }

        changeRequest.commitChanges()
        Firestore.firestore().collection(USERS_COLLECTION_PATH).document(id).setData(dto.dictionary)
    }
    
    static func delete(id: String, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        // not implementing delete user
    }
    
    static func syncAppUserWithFirebaseUser(firebaseUser: User) {
        var syncData: [String : Any] = [:]
        
        if let email = firebaseUser.email, !email.isEmpty {
            syncData["email"] = email
        }
        
        if let displayName = firebaseUser.displayName, !displayName.isEmpty {
            syncData["displayName"] = displayName
        }
        
        guard !syncData.isEmpty else {
            return
        }
        
        Firestore.firestore().collection(USERS_COLLECTION_PATH).document(firebaseUser.uid).updateData(syncData)
    }
    
    static func createAppUserFromFirebaseUser(firebaseUser: User, extraInfo: UpdateAppUser?) {
        let appUser = CreateAppUser(uid: firebaseUser.uid,
                              email: firebaseUser.email ?? "",
                              displayName: extraInfo?.displayName ?? firebaseUser.displayName,
                              address: extraInfo?.address,
                              phone: extraInfo?.phone ?? firebaseUser.phoneNumber)
        Self.create(appUser, onSuccess: {}, onError: {err in
            print("error in creating user: \(err.localizedDescription)")
        })
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
}
