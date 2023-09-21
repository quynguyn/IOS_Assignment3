//
//  HomeView.swift
//  Assignment3
//
//  Created by Duy Anh Pham on 09/09/2023.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var foodStore = FoodStore()
    @EnvironmentObject private var authStore : AuthStore
    @EnvironmentObject private var cartManager : CartManager
    @EnvironmentObject private var foodOrderStore : FoodOrderStore
    @State private var searchValue: String = ""
    @State private var selectedTab: Int = 0

    var foodCategories = ["All", "Noodle Dishes", "Dessert", "Rice Dishes", "Sandwich", "Salad"]
    
    @State private var selectedCategory = "All"
    @EnvironmentObject var mainFlowController: MainFlowController
        
    var body: some View {
        NavigationView {
            TabView(selection: $mainFlowController.selectedTab) {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Welcome, \(authStore.user?.displayName ?? "user")")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("#F1C27B"))
                        
                        Text("What would you like to eat today ?")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        HStack {
                            SearchView(search: $searchValue)
                            
                            Picker("Select category", selection: $selectedCategory) {
                                ForEach(foodCategories, id: \.self) { category in
                                    Text(category).tag(category)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                        
                        // Popular dishes
                        if searchValue.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Popular Dishes")
                                    .font(.system(size: 24, design: .rounded))
                                    .fontWeight(.bold)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack (spacing: 20) {
                                        ForEach(foodStore.top5RatedFoods) { foodItem in
                                            DishCard(food: foodItem)
                                        }
                                    }
                                    .padding()
                                }
                            }
                        }
                        
                        // Menu list
                        Text("Menu")
                            .font(.system(size: 24, design: .rounded))
                            .fontWeight(.bold)
                        
                        if foodStore.filteredList.isEmpty && !searchValue.isEmpty {
                            Text("No result found")
                                .foregroundColor(.gray)
                        } else {
                            LazyVStack {
                                ForEach(foodStore.filteredList, id: \.self) { foodItem in
                                    MenuView(food: foodItem)
                                        .onAppear {
                                            let isLast = foodItem == foodStore.filteredList.last
                                            if isLast {
                                                self.foodStore.nextPage()
                                            }
                                        }
                                }
                                
                                if foodStore.isGettingFood {
                                    ProgressView()
                                }
                            }
                            
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
                
                // StatusView
                StatusView()
                    .tabItem {
                        Image(systemName: "clock.fill")
                        Text("Status")
                    }
                    .tag(2)
                if let user = authStore.user {
                    ProfileView(user: user) // Updated tag to 3
                        .tabItem {
                            Image(systemName: "person.circle.fill")
                            Text("Profile")
                        }
                        .tag(3) // Updated tag to 3
                }
                
                
            }
            .accentColor(Color("#F1C27B"))
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            if let user = authStore.user {
                self.cartManager.loadFromUserDefaults()
                self.foodOrderStore.listenToFoodOrderList(userId: user.uid)
            }
        }
        .onChange(of: searchValue) { search in
            self.foodStore.filterByName(name: search)
        }
        .onChange(of: selectedCategory) { category in
            self.foodStore.filterByCategory(category: category)
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

struct DishCard: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var foodImage: UIImage? = nil
    var food: Food
    var body: some View {
        NavigationLink(destination: tabFoodView(food: food)){
            VStack(alignment: .leading, spacing: 8) {
                HStack() {
                    Spacer()
                    if let uiImage = foodImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .aspectRatio(1, contentMode: .fill)
                            .cornerRadius(10)
                    } else {
                        Rectangle()  // Placeholder till image loads
                            .foregroundColor(.gray)
                            .frame(width: 100, height: 100)
                    }
                    Spacer()
                }
                
                Text(food.name)
                    .fontWeight(.medium)
                    .lineLimit(1)
                
                HStack (spacing: 2) {
                    RatingView(rate: food.rate ?? 0)
                        .foregroundColor(.gray)
                        .font(.caption2)
                    
                    Spacer().frame(width: 5)
                    
                    Text("\(food.rate ?? 0, specifier: "%.1f")")
                        .foregroundColor(.gray)
                        .font(.caption2)
                }
                
                if let calories = food.calories {
                    Text("\(calories) calories")
                        .foregroundColor(Color(hex: 0xd8a936))
                        .font(.caption2)
                }
                
                Text("$ \(food.price, specifier: "%.2f")")
                    .font(.title3)
                    .foregroundColor(colorScheme == .dark ?.white :.black)

                
            }
            .padding()
            .background(Color(.tertiarySystemBackground))
            .cornerRadius(10)
            .shadow(radius: 5)
            .frame(width: 200)
            .onAppear {
                loadImageFromURL(urlString: food.image) { image in
                    self.foodImage = image
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct MenuView: View {
    @Environment(\.colorScheme) var colorScheme
    var food: Food
    @State private var foodImage: UIImage? = nil
    var body: some View {
        NavigationLink(destination: tabFoodView(food: food)) {
            HStack {
                if let uiImage = foodImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(1, contentMode: .fill)
                        .cornerRadius(10)
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
                            .foregroundColor(colorScheme == .dark ?.white :.black)
                        
                        Spacer()
                    }
                    
                    HStack (spacing: 2) {
                        RatingView(rate: food.rate ?? 0)
                            .foregroundColor(.gray)
                            .font(.caption2)
                        
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
                        .foregroundColor(colorScheme == .dark ?.white :.black)
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .background(Color(.tertiarySystemBackground))
            .cornerRadius(10)
            .shadow(radius: 5)
            .frame(maxWidth:.infinity)
            .onAppear {
                loadImageFromURL(urlString: food.image) { image in
                    self.foodImage = image
                }
            }
        }
    }
}

struct RatingView: View {
    var rate: Double
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<5) { index in
                let starIndex = Double(index)
                if rate >= starIndex + 1.0 {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("#F1C27B"))
                        .font(.caption2)
                } else if rate >= starIndex + 0.1 {
                    Image(systemName: "star.leadinghalf.fill")
                        .foregroundColor(Color("#F1C27B"))
                        .font(.caption2)
                } else {
                    Image(systemName: "star")
                        .foregroundColor(Color("#F1C27B"))
                        .font(.caption2)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        EnvironmentWrapper {
            Group{
                HomeView()
            }
            
        }
       
    }
}
