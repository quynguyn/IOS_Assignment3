/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author:
 Nguyen Quoc Hoang Trung - s3818328
 Vu Nguyet Minh - s3878520
 Pham Duy Anh - s3802674
 Nguyen Minh Hien - s3877996
 Nguyen Van Quy - s3878636
 Created  date: 8/9/2023
 Last modified: 23/9/2023
  Acknowledgement:
    “Full-text search | firestore | Firebase,” Google, https://firebase.google.com/docs/firestore/solutions/search?provider=algolia (accessed Sep. 21, 2023).
*/

import SwiftUI

struct tabFoodView: View {
    var food: Food
    @EnvironmentObject var cartManager: CartManager
    @State private var foodImage: UIImage? = nil
    var body: some View {
        TabView {
            DetailView(food: food)
                .tabItem {
                    Label("Details", systemImage: "info.circle")
                }
            IngredientView(food: food)
                .tabItem {
                    Label("Ingredients & Recipe", systemImage: "book.circle")
                }
        }
        .accentColor(Color(hex: 0xa2cdb0))
    }
}


struct tabFoodView_Previews: PreviewProvider {
    static var previews: some View {
        tabFoodView(food: burger).environmentObject(CartManager())
    }
}
