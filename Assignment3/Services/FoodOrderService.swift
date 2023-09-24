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
import FirebaseFirestore

struct FoodOrderService : FirebaseService {
    typealias GetType = FoodOrder
    
    typealias CreateType = CreateFoodOrder
    
    typealias UpdateType = UpdateFoodOrder
    
    static func fromFirebaseDocument(_ docSnapshot: DocumentSnapshot) -> FoodOrder? {
        return FirestoreUtils.fromFirebaseDocument(documentSnapshot: docSnapshot)
    }
    
    static func toFirebaseDocument(_ order: CreateFoodOrder) -> [String : Any] {
        var documentData = order.dictionary
        
        documentData["orderedAt"] = order.orderedAt.ISO8601Format()
        
        return documentData;
    }
     
    static func create(_ dto: CreateFoodOrder, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        Firestore
            .firestore()
            .collection(FOOD_ORDERS_COLLECTION_PATH)
            .addDocument(data: Self.toFirebaseDocument(dto)) {
                error in
                
                if let createError = error {
                    onError(createError)
                    return;
                }
                
                onSuccess()
            }
    }
    
    static func update(id: String, _ dto: UpdateFoodOrder, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        Firestore
            .firestore()
            .collection(FOOD_ORDERS_COLLECTION_PATH)
            .document(id)
            .updateData(dto.dictionary) {
                error in
                
                if let updateError = error {
                    onError(updateError)
                    return
                }
                
                onSuccess()
            }
    }
    
    static func delete(id: String, onSuccess: @escaping () -> Void, onError: @escaping (Error) -> Void) {
        Firestore
            .firestore()
            .collection(FOOD_ORDERS_COLLECTION_PATH)
            .document(id).delete {
            error in
            
            if let deleteError = error {
                onError(deleteError)
                return
            }
            
            onSuccess()
        }
    }
}
