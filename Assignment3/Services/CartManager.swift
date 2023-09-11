//
//  CartManager.swift
//  Assignment3
//
//  Created by Vũ Nguyệt Minh on 11/09/2023.
//

import Foundation

class CartManager: ObservableObject {
    @Published private(set) var items: [Food] = []
    @Published private(set) var total: Int = 0
    
    func addToCart(items: Food) {
        //items.append(item)
        //total += item.price
    }
    
    func deleteFromCart(items: Food) {
        
    }
}
