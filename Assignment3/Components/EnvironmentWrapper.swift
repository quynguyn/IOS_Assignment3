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

struct EnvironmentWrapper<Content: View>: View {
    @ViewBuilder var content: Content
    
    // Global objects
    @StateObject private var authStore = AuthStore()
    @StateObject private var foodOrderStore = FoodOrderStore()
    @StateObject private var cartManager = CartManager()
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            content
        }
        .environmentObject(authStore)
        .environmentObject(foodOrderStore)
        .environmentObject(cartManager)
    }
}

struct EnvironmentWrapper_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentWrapper {
            Text("EnvironmentWrapperView")
        }
    }
}
