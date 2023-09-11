//
//  CartManager.swift
//  Assignment3
//
//  Created by Vũ Nguyệt Minh on 11/09/2023.
//

import Foundation

class CartManager: ObservableObject {
    @Published private(set) var items: [Food] = []
    
    func addToCart(item: Food) {
        items.append(item)
    }
    
    func deleteFromCart(item: Food) {
        if let removeItem = items.firstIndex(where: {$0.id == item.id}) {
                    items.remove(at: removeItem)
                }
    }
}
