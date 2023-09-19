//
//  IngredientView.swift
//  Assignment3
//
//  Created by quy.nguyn on 19/09/2023.
//

import SwiftUI

struct IngredientView: View {
    var food: Food
    
    var body: some View {
        @EnvironmentObject var cartManager: CartManager
        
        ScrollView() {
            VStack(alignment: .leading, spacing: 16) {
                Text("Ingredients:")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0x85a389))
                    .padding(10)
                    .background(Color.white)
                    .border(Color.gray, width: 1)
                
                ForEach(food.ingredients ?? [], id: \.self) { ingredient in
                    HStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                        
                        Text("• \(ingredient)")
                            .font(.body)
                            .padding(.leading, 10)
                    }
                }
                
                Text("Recipe:")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0x85a389))
                    .padding(10)
                    .background(Color.white)
                    .border(Color.gray, width: 1)
                
                //                        ForEach(food.steps ?? [], id: \.self) { step in
                //                            Text("• \(step)")
                //                                .font(.body)
                //                                .padding(.leading, 10)
            }
        }
        .padding()
    }
}


struct IngredientView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView(food:burger).environmentObject(CartManager())
    }
}
