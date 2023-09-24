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


struct FoodService : FirebaseService {
    typealias GetType = Food
    typealias CreateType = CreateFood
    typealias UpdateType = UpdateFood
    
    // This is used in FoodStore to convert Firebase document snapshot to Food object
    static func fromFirebaseDocument(_ docSnapshot: DocumentSnapshot) -> Food? {
        return FirestoreUtils.fromFirebaseDocument(documentSnapshot: docSnapshot)
    }
    
    /**
     Create a CreateFood object, init the object with all the necessary info:
     var createFood = CreateFood(...)
     
     Then call this function with the object above:
     FoodService.create(createFood)
        
     You can add onSuccess, onError callbacks and update UI accordingly
     */
    static func create(
        _ food: CreateFood,
        onSuccess: @escaping () -> Void = {},
        onError: @escaping (_ error: any Error) -> Void = {error in }
    ) {
        Firestore
            .firestore()
            .collection(FOODS_COLLECTION_PATH)
            .addDocument(data: food.dictionary) {
                error in
                
                if let createError = error {
                    onError(createError)
                    return;
                }
                
                onSuccess()
            }
    }
    
    /**
     Create an empty UpdateFood:
     var update = UpdateFood()
     
     Add any update you want to perform on the item
     Example:
     - name: update.name = "New name"
     - description: update.description = "New description"
     
     Then call this function with the update object above:
     FoodService.update(id: id, update)
        
     You can add onSuccess, onError callbacks and update UI accordingly
     */
    static func update(id: String,
                       _ food: UpdateFood,
                       onSuccess: @escaping () -> Void = {},
                       onError: @escaping (_ error: any Error) -> Void = {error in }
    ) {
        Firestore.firestore().collection(FOODS_COLLECTION_PATH).document(id).updateData(food.dictionary) {
            error in
            
            if let updateError = error {
                onError(updateError)
                return
            }
            
            onSuccess()
        }
    }
    
    static func delete(id: String,
                       onSuccess: @escaping () -> Void = {},
                       onError: @escaping (_ error: any Error) -> Void = {error in }
    ) {
        Firestore.firestore().collection(FOODS_COLLECTION_PATH)
            .document(id).delete {
            error in
            
            if let deleteError = error {
                onError(deleteError)
                return
            }
            
            onSuccess()
        }
    }
    
    // https://firebase.google.com/docs/reference/swift/firebasefirestore/api/reference/Classes/FieldPath#/c:objc(cs)FIRFieldPath(cm)documentID
    static func getManyFoods(idList: [String]) async -> [Food] {
        do {
            let querySnapshot = try await Firestore
                .firestore()
                .collection(FOODS_COLLECTION_PATH)
                .whereField(FieldPath.documentID(), in: idList)
                .getDocuments()
            
            return querySnapshot.documents.compactMap(Self.fromFirebaseDocument)
        }
        catch {
            return [];
        }
    }
}
