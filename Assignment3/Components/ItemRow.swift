//
//  ItemRow.swift
//  Assignment3
//
//  Created by Vũ Nguyệt Minh on 12/09/2023.
//

import SwiftUI

struct ItemRow: View {
    @EnvironmentObject var cartManager: CartManager
    var item: Food
    
    var body: some View {
        HStack {
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 60)
                .cornerRadius(10)
            VStack(alignment: .leading, spacing: 10) {
                Text(item.name)
                    .bold()
                Text("$\(item.price, specifier: "%.2f")")
            }
            Spacer()
            Image(systemName: "trash")
                .onTapGesture {
                    cartManager.deleteFromCart(item: item)
                }
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item: FoodList[0])
            .environmentObject(CartManager())
    }
}
