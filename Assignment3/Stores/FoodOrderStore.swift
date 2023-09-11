//
//  FoodOrderStore.swift
//  Assignment3
//
//  Created by Trung Nguyen on 11/09/2023.
//

import Foundation
import FirebaseAuth
@MainActor
class FoodOrderStore : ObservableObject {
    @Published var foodOrders: [FoodOrderWithFoodList] = []
    
    init(userId: String) {
        Task.init {
            await self.initFoodOrderList(userId: userId)
        }
    }
    
    private func initFoodOrderList(userId: String) async {
        let foodOrderListOfUser = await FoodOrderService.getFoodOrderList(userId: userId)
        
        for foodOrder in foodOrderListOfUser {
            let foodOrderWithFoodList = await FoodService.getFoodList(foodOrder: foodOrder)
            
            if let foodOrderWithFoodList {
                foodOrders.append(foodOrderWithFoodList)
            }
        }
    }
    
}
