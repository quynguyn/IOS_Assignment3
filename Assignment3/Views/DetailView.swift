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
    @State private var foodImages: [UIImage?] = []
    @State private var showToast = false
    @State private var showDetails = false
    
    init(food: Food) {
        self.food = food
        _foodImages = State(initialValue: Array(repeating: nil, count: food.thumbnail.count)) // Initialize the array with nils
    }
    var food: Food
    private let toastOpstions = SimpleToastOptions(
        alignment: .top,
        hideAfter: 0.75,
        backdrop: Color.black.opacity(0.1),
        animation: .default,
        modifierType: .slide,
        dismissOnTap: true
    )
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 16) {
                        ForEach(food.thumbnail.indices, id: \.self) { index in
                            if let uiImage = foodImages[index] {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: 400)
                                    .frame(height: 500)
                                    .clipped()
                                    .shadow(radius: 5)
                            } else {
                                Rectangle()
                                    .foregroundColor(.gray)
                                    .frame(width: 150, height: 150)
                                    .onAppear {
                                        loadImageFromURL(urlString: food.thumbnail[index]) { image in
                                            self.foodImages[index] = image
                                        }
                                    }
                            }
                        }
                    }
                }
                .edgesIgnoringSafeArea(.top)
                
                
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
                    
                    Button(action: {
                                        showDetails.toggle()
                                    }) {
                                        Text(showDetails ? "Hide Details" : "Show Details")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color(hex: 0xa2cdb0))
                                            .cornerRadius(10)
                                    }
                }.padding()
                
            }
            
            .edgesIgnoringSafeArea(.top)
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
        }
    }
}


struct detailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(food: burger)
            .environmentObject(CartManager())
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
    ingredients: nil
)
