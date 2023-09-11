//
//  CartView.swift
//  Assignment3
//
//  Created by Vũ Nguyệt Minh on 11/09/2023.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    var body: some View {
        ScrollView {
            if (cartManager.items.count > 0) {
                ForEach(cartManager.items, id: \.id) {
                    item in
                    ItemRow(item: item)
                }
            }
            else {
                Text("Your cart is empty!")
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}
