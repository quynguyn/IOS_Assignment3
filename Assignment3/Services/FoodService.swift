//
//  FoodService.swift
//  Assignment3
//
//  Created by Trung Nguyen on 10/09/2023.
//

import Foundation
import FirebaseFirestore


struct FoodService : FirebaseService {
    typealias CreateType = CreateFood
    typealias UpdateType = UpdateFood
    
    // This is used in FoodStore to convert Firebase document snapshot to Food object
    static func fromFirebaseDocument(_ docSnapshot: DocumentSnapshot) -> Food? {
        
        let id = docSnapshot.documentID
        let name = docSnapshot.get("name") as? String
        let image = docSnapshot.get("image") as? String
        let category = docSnapshot.get("category") as? String
        let price = docSnapshot.get("price") as? Double
        let description = docSnapshot.get("description") as? String
        
        let calories = docSnapshot.get("calories") as? Int
        let rate = docSnapshot.get("rate") as? Int
        let comment = docSnapshot.get("comment") as? String
        let ingredients = docSnapshot.get("ingredients") as? [String]
        
        guard
            let name,
            let image,
            let category,
            let price,
            let description
        else {
            return nil
        }
        
        return Food(id: id,
                    name: name,
                    image: image,
                    category: category,
                    price: price,
                    description: description,
                    calories: calories,
                    rate: rate,
                    comment: comment,
                    ingredients: ingredients
                )
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
    
}
