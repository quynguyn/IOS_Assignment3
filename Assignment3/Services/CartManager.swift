//
//  CartManager.swift
//  Assignment3
//
//  Created by Vũ Nguyệt Minh on 11/09/2023.
//

import Foundation

class CartManager: ObservableObject {
    @Published private(set) var items: [Food] = []
    @Published private(set) var total: Double = 0
    
    func addToCart(item: Food) {
        items.append(item)
        total += item.price
    }
    
    func deleteFromCart(item: Food) {
        if let removeItem = items.firstIndex(where: {$0.id == item.id}) {
            items.remove(at: removeItem)
            total -= item.price
        }
    }
    
    // Calculate the total price of items in the cart
    var totalPrice: Double {
        items.reduce(0) { (result, food) -> Double in
            result + food.price
        }
    }
}
