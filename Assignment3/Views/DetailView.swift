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
            VStack(spacing: 20) {
                Image(food.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: 300) // Adjust as needed
                    .clipped()
                    .shadow(radius: 5)
                
                VStack(alignment: .center, spacing: 20) {
                    Text(food.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.black))
                    
                    Text("Price: $\(food.price, specifier: "%.2f")")
                        .font(.headline)
                    
                    ScrollView {
                        Text(food.description)
                            .font(.body)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal) // Add horizontal padding
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            if quantity > 1 {
                                quantity -= 1
                            }
                        }) {
                            Image(systemName: "minus.rectangle")
                                .font(.title)
                                .foregroundColor(Color(hex: 0xf1c27b))
                        }
                        
                        Text("Quantity: \(quantity)")
                            .font(.headline)
                        
                        Button(action: {
                            quantity += 1
                        }) {
                            Image(systemName: "plus.rectangle")
                                .font(.title)
                                .foregroundColor(Color(hex: 0xf1c27b))
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
                            .background(Color(hex: 0xffd89c))
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitle("Food Detail", displayMode: .automatic)
    }
}


struct detailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(food: burger)
    }
}

let burger = Food(
    id: "123",
    name: "Delicious Burger",
    image: "burger",
    thumbnail: "burger_thumbnail",
    category: "Fast Food",
    price: 9.99,
    description: "A mouthwatering burger with all the toppings.",
    calories: nil,
    rate: nil,
    comment: nil,
    ingredients: nil
)
