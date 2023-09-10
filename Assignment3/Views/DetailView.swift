//
//  detailView.swift
//  Assignment3
//
//  Created by quy.nguyn on 09/09/2023.
//

import SwiftUI

struct DetailView: View {
    @State private var quantity = 1
    var food: Food
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image(food.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .cornerRadius(10)
                .shadow(radius: 5)
            
            Text(food.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(.black)) // Custom color
            
            Text("Price: $\(food.price, specifier: "%.2f")")
                .font(.headline)
            
            Text(food.description)
                .font(.body)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            HStack {
                Button(action: {
                    if quantity > 1 {
                        quantity -= 1
                    }
                }) {
                    Image(systemName: "minus.rectangle")
                        .font(.title)
                        .foregroundColor(Color(hex: 0xffd89c))
                }
                
                Text("Quantity: \(quantity)")
                    .font(.headline)
                
                Button(action: {
                    quantity += 1
                }) {
                    Image(systemName: "plus.rectangle")
                        .font(.title)
                        .foregroundColor(Color(hex: 0xffd89c))
                }
            }
            
            Button(action: {
                // Implement cart functionality here
                // You can add this food item to the cart
            }) {
                Text("Add to Cart")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: 0xf1c27b))
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationBarTitle("Food Detail", displayMode: .inline)
    }
}

struct detailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(food: burger)
    }
}

let burger = Food(name: "Delicious Burger",
                  image: "burger",
                  price: 9.99,
                  description: "A mouthwatering burger with all the toppings.",
                  category: "Fast Food")
