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
    @State private var foodImages: [UIImage?] = []
    @State private var showToast = false
    
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
        VStack {
            VStack(spacing: 20) {
                GeometryReader{ geometry in
                    
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 16) {
                            ForEach(food.thumbnail.indices, id: \.self) { index in
                                if let uiImage = foodImages[index] {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width)
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
                            .cornerRadius(10)
                        }
                    }
                }
                .edgesIgnoringSafeArea(.top)
                
                
                VStack(alignment: .center, spacing: 20) {
                    Text(food.name)
                        .font(.title2)
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
                            .background(Color(hex: 0xffd89c))
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
        DetailView(food: burger).environmentObject(CartManager())
    }
}

let burger = Food(
    id: "123",
    name: "Delicious Burger",
    image: "https://huyennganbakery.vn/uploads/files/Cac%20lo%E1%BA%A1i%20banh%20khac/6be57415a15a5904004b.jpg",
    thumbnail: ["https://runawayrice.com/wp-content/uploads/2018/05/Flan-Caramel-Custard-1.jpg","https://yummyvietnam.net/wp-content/uploads/2018/08/vietnamese-banh-flan-recipe-with-condensed-milk20.jpg","https://www.mashed.com/img/gallery/the-untold-truth-of-flan/l-intro-1645644351.jpg"],
    category: "Fast Food",
    price: 9.99,
    description: "A mouthwatering burger with all the toppings.",
    calories: nil,
    rate: nil,
    comment: nil,
    ingredients: ["sugary caramel","milk","eggs","vanilla or coffee-flavored","sugar"],
    recipe: ["Combine maple syrup, coconut sugar (or brown sugar), vanilla extract, and salt, in a medium-sized saucepan over medium heat.", "Cook for approximately three minutes until the mixture is bubbling and the sugar has dissolved.","Remove from heat and carefully divide the caramel into the ramekins or molds, ensuring an even coating on the bottom. Set aside.","Combine coconut milk, sugar, and vanilla extract in the same saucepan.","In a small bowl or glass, using the tines of a fork mix the agar agar powder and cornstarch (or tapioca starch or arrowroot) with plant-based milk until well combined.",
             "Add this mixture to the saucepan.","Place the saucepan over medium heat and stir continuously until the mixture comes to a gentle boil. Reduce the heat to low and simmer for three minutes, stirring constantly, to activate the agar agar and thicken the custard.","Carefully pour the custard mixture into the ramekins or mold with the caramel, filling them to the top.","Refrigerate for a minimum of 90 minutes until set. For best results, refrigerate the flans overnight to ensure a firm texture.","To unmold the flans, run a knife around the edges to loosen them. Place a serving plate over the ramekin or mold, then carefully invert it, allowing the caramel to drizzle over the flan."]
)
