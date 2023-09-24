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

enum FoodOrderStatus : String, Codable {
    case pending
    case preparing
    case delivered
}

struct CreateFoodOrder : Codable {
    let userId: String
    let foodIdList: [String]
    let status: FoodOrderStatus
    let orderedAt: Date
    
    let deliveryAddress: String
    let contactName: String
    let contactPhone: String
}

struct UpdateFoodOrder : Codable {
    var foodIdList: [String]? = nil
    var status: FoodOrderStatus? = nil
    
    init(foodIdList: [String]? = nil, status: FoodOrderStatus? = nil) {
        self.foodIdList = foodIdList
        self.status = status
    }
}

struct FoodOrder : Identifiable, Codable, Hashable {
    let id: String
    let userId: String
    let foodIdList: [String]
    let status: FoodOrderStatus
    let orderedAt: String
    
    let deliveryAddress: String?
    let contactName: String?
    let contactPhone: String?
    
    var orderedAtDate: Date {
        DateUtils.getDateFromString(self.orderedAt) ?? Date();
    }
}

struct FoodOrderWithFoodList {
    let id: String
    let userId: String
    let foodList: [Food]
    let status: FoodOrderStatus
    let orderedAt: Date
    
    let deliveryAddress: String?
    let contactName: String?
    let contactPhone: String?
    
    init(userId: String, foodOrder: FoodOrder, foodList: [Food]) {
        self.id = foodOrder.id
        self.userId = userId
        self.foodList = foodList
        self.status = foodOrder.status
        self.orderedAt = foodOrder.orderedAtDate
        self.deliveryAddress = foodOrder.deliveryAddress
        self.contactName = foodOrder.contactName
        self.contactPhone = foodOrder.contactPhone
    }
}
