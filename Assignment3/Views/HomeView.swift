//
//  HomeView.swift
//  Assignment3
//
//  Created by Duy Anh Pham on 09/09/2023.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @StateObject var cartManager = CartManager()
    @StateObject private var foodStore = FoodStore()
    @EnvironmentObject private var authStore : AuthStore
    @State private var searchValue: String = ""
    @State private var selectedTab: Int = 0
    @Binding var isLoggedIn: Bool
    
    var filteredFoodList: [Food] {
        if searchValue.isEmpty {
            return foodStore.foodList
        } else {
            return foodStore.foodList.filter { food in
                return food.name.lowercased().contains(searchValue.lowercased())
            }
        }
    }
    
    var body: some View {
        if isLoggedIn{
            NavigationView {
                TabView(selection: $selectedTab) {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Welcome, \(authStore.user?.displayName ?? "user")")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(Color("#F1C27B"))
                            
                            Text("What would you like to eat today ?")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            SearchView(search: $searchValue)
                            
                            PopularDishesView()
                            
                            Text("Menu")
                                .font(.system(size: 24, design: .rounded))
                                .fontWeight(.bold)
                            
                            ForEach(filteredFoodList) { foodItem in
                                MenuView(food: foodItem)
                            }
                        }
                        .padding()
                    }
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)
                    
                    // ShoppingCartView
                    CartView()
                        .tabItem {
                            //CartButton(numberOfItems: cartManager.items.count)
                            Image(systemName: "cart.fill")
                            Text("Cart")
                        }
                        .tag(1)
                    
                    // HistoryView
                    HistoryView()
                        .tabItem {
                            Image(systemName: "clock.fill")
                            Text("History")
                        }
                        .tag(2)
                    
                    ProfileView(isLoggedIn: $isLoggedIn) // Updated tag to 3
                        .tabItem {
                            Image(systemName: "person.circle.fill")
                            Text("Profile")
                        }
                        .tag(3) // Updated tag to 3
                    
                }
                .accentColor(Color("#F1C27B"))
            }
            .navigationBarBackButtonHidden()
        
    } else {
        LogInView()
    }
}
}


struct SearchView: View {
    @Binding var search: String
    var body: some View {
        HStack() {
            Image(systemName: "magnifyingglass")
            
            TextField("Search for dish", text: $search)
                .textInputAutocapitalization(.none)
                .keyboardType(.default)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

struct PopularDishesView: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            Text("Popular Dishes")
                .font(.system(size: 24, design: .rounded))
                .fontWeight(.bold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 40) {
                    DishCard()
                    DishCard()
                    DishCard()
                }
                .padding()
            }
        }
    }
}

struct DishCard: View {
    var body: some View {
        NavigationLink(destination: DetailView(food: burger)){
            ZStack {
                VStack(alignment: .leading, spacing: 8) {
                    
                    Image(systemName: "heart")
                        .foregroundColor(.gray)
                        .padding(.bottom,60)
                    
                    Text("Broken Rice with Grilled Pork")
                        .fontWeight(.medium)
                        .lineLimit(1)
                    
                    HStack (spacing: 2) {
                        ForEach(0 ..< 5) { item in
                            Image(systemName: "star.fill")
                                .renderingMode(.template)
                                .foregroundColor(Color("#F1C27B"))
                                .font(.caption2)
                        }
                        
                        Spacer().frame(width: 5)
                        
                        Text("4.5")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    
                    Text("120 calories")
                        .foregroundColor(Color(hex: 0xd8a936))
                        .font(.caption)
                    
                    HStack {
                        Image(systemName: "dollarsign")
                            .foregroundColor(Color("#E25E3E"))
                            .font(.caption2)
                        Text("40,000 VND")
                            .foregroundColor(.gray)
                            .font(.caption2)
                        
                    }
                }
                .padding()
                .background(Color(.tertiarySystemBackground))
                .cornerRadius(20)
                .shadow(radius: 5)
                .frame(width: 200)
                
                Image("image1")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .offset(x: 60, y: -60)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct MenuView: View {
    var food: Food
    @State private var foodImage: UIImage? = nil
    var body: some View {
        NavigationLink(destination: DetailView(food: food)) {
            HStack {
                if let uiImage = foodImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(1, contentMode: .fill)
                        .cornerRadius(20)
                } else {
                    Rectangle()  // Placeholder till image loads
                    .foregroundColor(.gray)
                    .frame(width: 100, height: 100)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(food.name)
                            .fontWeight(.medium)
                            .lineLimit(1)
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    
                    HStack (spacing: 2) {
                        ForEach(0 ..< 5) { item in
                            Image(systemName: "star.fill")
                                .renderingMode(.template)
                                .foregroundColor(Color("#F1C27B"))
                                .font(.caption2)
                        }
                        
                        Spacer().frame(width: 5)
                        
                        Text("\(food.rate ?? 0, specifier: "%.1f")")
                            .foregroundColor(.gray)
                            .font(.caption2)
                    }
                    
                    if let calories = food.calories {
                        Text("\(calories) calories")
                            .foregroundColor(Color(hex: 0xcc9849))
                            .font(.caption)
                    }
                    
                    Text("$ \(food.price, specifier: "%.2f")")
                        .font(.title3)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .background(Color(.tertiarySystemBackground))
            .cornerRadius(20)
            .shadow(radius: 5)
            .frame(maxWidth:.infinity)
            .onAppear {
                loadImageFromURL(urlString: food.thumbnail) { image in
                    self.foodImage = image
                }
            }
        }
    }
}




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        EnvironmentWrapper {
            Group{
                HomeView(isLoggedIn: .constant(true))
                //HomeView(isLoggedIn: .constant(false))
            }
            
        }
       
    }
}
