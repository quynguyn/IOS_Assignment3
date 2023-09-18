//
//  FoodOrderStore.swift
//  Assignment3
//
//  Created by Trung Nguyen on 11/09/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
class FoodOrderStore : ObservableObject {
    @Published var foodOrders: [FoodOrderWithFoodList] = []
    
    private var listener : ListenerRegistration?
    
    func listenToFoodOrderList(userId: String) {
        self.listener?.remove()
        self.listener = Firestore
           .firestore()
           .collection(FOOD_ORDERS_COLLECTION_PATH)
           .whereField("userId", isEqualTo: userId).addSnapshotListener {
               (querySnapshot, error) in
               guard let documents = querySnapshot?.documents else {
                   return;
               }
               
               Task.init(priority: .high) {
                   let foodOrderList = documents.compactMap(FoodOrderService.fromFirebaseDocument)
                   
                   var foodOrdersWithFoodList: [FoodOrderWithFoodList] = []
                   
                   for order in foodOrderList {
                       let foodListFromOrder = await FoodService.getManyFoods(idList: order.foodIdList)
                       
                       let foodOrderWithFoodList = FoodOrderWithFoodList(userId: userId, foodOrder: order, foodList: foodListFromOrder)
                       
                       foodOrdersWithFoodList.append(foodOrderWithFoodList)
                   }
                   
                   self.foodOrders = foodOrdersWithFoodList
               }
           }
    }
    
    deinit {
        self.listener?.remove()
    }
    
}
