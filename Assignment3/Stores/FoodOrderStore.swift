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
