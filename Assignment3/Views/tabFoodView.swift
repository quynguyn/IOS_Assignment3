//
//  tabFoodView.swift
//  Assignment3
//
//  Created by quy.nguyn on 19/09/2023.
//

import SwiftUI

struct tabFoodView: View {
    var food: Food
    @EnvironmentObject var cartManager: CartManager
    @State private var foodImage: UIImage? = nil
    var body: some View {
        TabView {
            DetailView(food: food)
                .tabItem {
                    Label("Details", systemImage: "info.circle")
                }
            IngredientView(food: food)
                .tabItem {
                    Label("Ingredients & Recipe", systemImage: "book.circle")
                }
        }
        .accentColor(Color(hex: 0xa2cdb0))
    }
}


struct tabFoodView_Previews: PreviewProvider {
    static var previews: some View {
        tabFoodView(food: burger).environmentObject(CartManager())
    }
}
