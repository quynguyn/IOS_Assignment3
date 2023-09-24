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
        self.saveToUserDefaults()
    }
    
    func deleteFromCart(item: Food) {
        if let removeItem = items.firstIndex(where: {$0.id == item.id}) {
            items.remove(at: removeItem)
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
        
        self.saveToUserDefaults()
    }

}
