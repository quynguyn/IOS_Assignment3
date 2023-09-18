//
//  FoodOrderService.swift
//  Assignment3
//
//  Created by Trung Nguyen on 11/09/2023.
//

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
    
    static func getFoodOrderList(userId : String) async -> [FoodOrder]  {
        do {
            let querySnapshot = try await Firestore
               .firestore()
               .collection(FOOD_ORDERS_COLLECTION_PATH)
               .whereField("userId", isEqualTo: userId)
               .getDocuments()
            return querySnapshot.documents.compactMap(Self.fromFirebaseDocument)
        } catch {
            print("Error: \(error.localizedDescription)")
            return []
        }
    }
}
