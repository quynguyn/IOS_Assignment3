//
//  detailView.swift
//  Assignment3
//
//  Created by quy.nguyn on 09/09/2023.
//

import SwiftUI
import SimpleToast
struct DetailView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var quantity = 1
    @State private var foodImage: UIImage? = nil
    @State private var showToast = false
    
    var food: Food
    private let toastOpstions = SimpleToastOptions(
        alignment: .top,
        hideAfter: 1,
        animation: .default,
        modifierType: .slide,
        dismissOnTap: true
    )
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                
                if let uiImage = foodImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(height: 300) // Adjust as needed
                        .clipped()
                        .shadow(radius: 5)
                } else {
                    Rectangle()  // Placeholder till image loads
                        .foregroundColor(.gray)
                        .frame(width: 100, height: 100)
                }
            
                
                VStack(alignment: .center, spacing: 20) {
                    Text(food.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.black))
                    
                    HStack{
                        Text("Price: $\(food.price, specifier: "%.2f")")
                            .font(.headline)
                        
                        Spacer()
                        
                        if let calories = food.calories {
                            Text("\(calories) calories")
                                .font(.headline)
                                .foregroundColor(Color(hex: 0xcc9849))
                        }
                    }
                    
                    
                    ScrollView {
                        Text(food.description)
                            .font(.body)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal) // Add horizontal padding
                    
                    Spacer()
                    
//                    HStack {
//                        Button(action: {
//                            if quantity > 1 {
//                                quantity -= 1
//                            }
//                        }) {
//                            Image(systemName: "minus.rectangle")
//                                .font(.title)
//                                .foregroundColor(Color(hex: 0xf1c27b))
//                        }
//
//                        Text("Quantity: \(quantity)")
//                            .font(.headline)
//
//                        Button(action: {
//                            quantity += 1
//                        }) {
//                            Image(systemName: "plus.rectangle")
//                                .font(.title)
//                                .foregroundColor(Color(hex: 0xf1c27b))
//                        }
//                    }
                    
                    //cart function
                    Button(action: {
                        cartManager.addToCart(item: food)
                        showToast.toggle()
                    }) {
                        Text("Add to Cart")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: 0xa2cdb0))
                            .cornerRadius(10)
                    }
                }
                .simpleToast(isPresented: $showToast, options: toastOpstions){
                    HStack{
                        Image(systemName: "checkmark.seal.fill")
                        Text("Added to Cart").bold()
                    }
                        .padding(20)
                        .background(Color(hex: 0xf1c27b))
                        .foregroundColor(Color.white)
                        .cornerRadius(15)
                }
                .padding()
            }
            .edgesIgnoringSafeArea(.top)
            .onAppear {
                loadImageFromURL(urlString: food.image) { image in
                    self.foodImage = image
                }
            }
            
        }
    }
}


struct detailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(food: burger).environmentObject(CartManager())
    }
}

let burger = Food(
    id: "123",
    name: "Delicious Burger",
    image: "burger",
    thumbnail: ["burger_thumbnail"],
    category: "Fast Food",
    price: 9.99,
    description: "A mouthwatering burger with all the toppings.",
    calories: nil,
    rate: nil,
    comment: nil,
    ingredients: nil,
    recipe: []
)
