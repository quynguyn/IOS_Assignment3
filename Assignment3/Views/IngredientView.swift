//
//  IngredientView.swift
//  Assignment3
//
//  Created by quy.nguyn on 19/09/2023.
//

import SwiftUI

struct IngredientView: View {
    var food: Food
    @EnvironmentObject var cartManager: CartManager
    @State private var foodImage: UIImage? = nil
    
    var body: some View {
        
        ScrollView() {
            
            ZStack(alignment: .bottom){
                if let uiImage = foodImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(20)
                } else {
                    Rectangle()  // Placeholder till image loads
                    .foregroundColor(.gray)
                    .frame(width: 400, height: 400)
                }
                
                Text(food.name)
                    .padding()
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .background(.white)
                    .cornerRadius(25)
                    .foregroundColor(Color(.black))
            }
            VStack(alignment: .leading, spacing: 16) {
                Text("Ingredients:")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0x85a389))
                    .padding(10)
                    .background(Color.white)
                
                
                ForEach(food.ingredients ?? [], id: \.self) { ingredient in
                    HStack {
                        Text("❥ \(ingredient)")
                            .foregroundColor(.black)
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
                
                ForEach(food.recipe , id: \.self) { recipe in
                    Text("➜ \(recipe)")
                        .font(.body)
                        .padding(.leading, 10)
                }
            }
            .onAppear {
                loadImageFromURL(urlString: food.image) { image in
                    self.foodImage = image
                }
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.top)
    }
}
    
    
    struct IngredientView_Previews: PreviewProvider {
        static var previews: some View {
            IngredientView(food:burger).environmentObject(CartManager())
        }
    }
