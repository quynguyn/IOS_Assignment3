//
//  HomeView.swift
//  Assignment3
//
//  Created by Duy Anh Pham on 09/09/2023.
//

import SwiftUI

struct HomeView: View {
    @State private var searchValue: String = ""
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Welcome, Dustin")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("#85A389"))
                
                Text("What would you like to eat today ?")
                    .font(.title)
                    .fontWeight(.bold)
                
                SearchView(search: $searchValue)
                
                PopularDishesView()
                
                Text("Menu")
                    .font(.system(size: 24, design: .rounded))
                    .fontWeight(.bold)

                
                MenuView()
                
                MenuView()
            }
            .padding()
        }
    }
}

struct SearchView: View {
    @Binding var search: String
    var body: some View {
        HStack() {
            Image(systemName: "magnifyingglass")
            
            TextField("Search for dish", text: $search)
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
                        .font(.caption2)
                }
                
                Text("120 calories")
                    .foregroundColor(Color("#F1C27B"))
                    .font(.caption2)
                
                HStack {
                    Image(systemName: "dollarsign")
                        .foregroundColor(Color("#E25E3E"))
                        .font(.caption2)
                    Text("40,000 VND")
                        .foregroundColor(.gray)
                        .font(.caption2)
                    Spacer().frame(width: 20)
                    
                    Image(systemName: "location.fill")
                        .foregroundColor(Color("#A2CDB0"))
                        .font(.caption2)
                    Text("1.7km")
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
}

struct MenuView: View {
    var body: some View {
        HStack {
            Image("image1")
                .resizable()
                .frame(width: 100, height: 100)
                .aspectRatio(1, contentMode: .fill)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("Broken Rice with Grilled Pork")
                        .fontWeight(.medium)
                        .lineLimit(1)
                    
                    Image(systemName: "heart")
                        .foregroundColor(.gray)
                }
                
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
                        .font(.caption2)
                }
                
                Text("120 calories")
                    .foregroundColor(Color("#F1C27B"))
                    .font(.caption2)
                
                HStack {
                    Image(systemName: "dollarsign")
                        .foregroundColor(Color("#E25E3E"))
                        .font(.caption2)
                    Text("40,000 VND")
                        .foregroundColor(.gray)
                        .font(.caption2)
                    Spacer().frame(width: 20)
                    
                    Image(systemName: "location.fill")
                        .foregroundColor(Color("#A2CDB0"))
                        .font(.caption2)
                    Text("1.7km")
                        .foregroundColor(.gray)
                        .font(.caption2)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color(.tertiarySystemBackground))
        .cornerRadius(20)
        .shadow(radius: 5)
        .frame(maxWidth:.infinity)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
