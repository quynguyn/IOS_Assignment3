//
//  FoodStore.swift
//  Assignment3
//
//  Created by Duy Anh Pham on 13/09/2023.
//

import Foundation
import FirebaseFirestore

@MainActor
class FoodStore : ObservableObject {
    @Published var foodList : [Food] = []
    
    private var db = Firestore.firestore()
    
    private var foodListListener : ListenerRegistration?
    
    init() {
        self.findFoodList()
    }
    
    private func findFoodList() {
        self.foodListListener = self.db.collection("foods").addSnapshotListener{
            (querySnapshot, error) in
                
            guard let documents = querySnapshot?.documents else {
                return;
            }
            
            self.foodList = documents.compactMap(FoodService.fromFirebaseDocument)
        }
    }
    
    deinit {
        self.foodListListener?.remove()
    }
}
