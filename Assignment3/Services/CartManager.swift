//
//  CartManager.swift
//  Assignment3
//
//  Created by Vũ Nguyệt Minh on 11/09/2023.
//

import Foundation
import FirebaseAuth

private func loadCartFromUserDefaults(userId: String) -> [Food]? {
    guard let data = UserDefaults.standard.data(forKey: "\(CART_UD_KEY)_\(userId)") else {
        return nil
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode([Food].self, from: data)
    } catch {
        return nil
    }
}

private func saveCartToUserDefaults(userId: String, foods: [Food]) {
    do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(foods)
        UserDefaults.standard.set(data, forKey: "\(CART_UD_KEY)_\(userId)")
    } catch {
        print("Unable to Encode (\(error))")
    }
}

class CartManager: ObservableObject {
    @Published private(set) var items: [Food] = []
    @Published private(set) var total: Double = 0
    
    func loadFromUserDefaults() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        let cartFromUserDefaults = loadCartFromUserDefaults(userId: user.uid)
        if let cartFromUserDefaults {
            items = cartFromUserDefaults;
        }
    }
    
    func saveToUserDefaults() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        saveCartToUserDefaults(userId: user.uid, foods: self.items)
    }
    
    func addToCart(item: Food) {
        items.append(item)
        total += item.price
        
        self.saveToUserDefaults()
    }
    
    func deleteFromCart(item: Food) {
        if let removeItem = items.firstIndex(where: {$0.id == item.id}) {
            items.remove(at: removeItem)
            total -= item.price
        }
        
        self.saveToUserDefaults()
    }
    
    // Calculate the total price of items in the cart
    var totalPrice: Double {
        items.reduce(0) { (result, food) -> Double in
            result + food.price
        }
    }
    
    //Empty cart after placing order
    func emptyCart() {
        items.removeAll()
        total = 0
        
        self.saveToUserDefaults()
    }

}
