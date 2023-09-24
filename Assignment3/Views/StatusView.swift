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

struct StatusView: View {
    @EnvironmentObject private var foodOrderStore : FoodOrderStore
    
    func totalPrice(for order: FoodOrderWithFoodList) -> Double {
        order.foodList.reduce(0.0) { total, food in
            total + food.price
        }
    }
    
    var sortedOrders: [FoodOrderWithFoodList] {
        foodOrderStore.foodOrders.sorted(by: { $0.orderedAt > $1.orderedAt })
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Status")
                .font(.system(size: 24, design: .rounded))
                .fontWeight(.bold)
            
            ScrollView(showsIndicators: false) {
                if foodOrderStore.foodOrders.isEmpty {
                    Image("bill")
                        .resizable()
                        .frame(width: 200, height: 200, alignment: .center)
                        .padding()
                    Text("You haven't ordered anything.")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                else {
                    VStack(spacing: 16) {
                        ForEach(sortedOrders, id: \.id) { order in
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    HStack {
                                        Text("Order")
                                            .fontWeight(.bold)
                                            .font(.caption)
                                        
                                        Text("#\(order.id)")
                                            .foregroundColor(.gray)
                                            .font(.caption)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(formatDate(order.orderedAt))
                                        .font(.caption2)
                                }
                                
                                HStack {
                                    Image("logo")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                        .aspectRatio(1, contentMode: .fill)
                                        .cornerRadius(20)
                                        .shadow(radius: 5)
                                    Spacer().frame(width: 20)
                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack {
                                            Text("$ \(totalPrice(for: order), specifier: "%.2f")")
                                                .fontWeight(.bold)
                                            
                                            Text("(\(order.foodList.count) \(order.foodList.count == 1 ? "item" : "items"))")
                                                .foregroundColor(.gray)
                                            
                                        }
                                        
                                        
                                        Text("\(order.deliveryAddress ?? "N/A")")
                                            .foregroundColor(.gray)
                                            .lineLimit(1)
                                        
                                        
                                        Text(order.status.rawValue.capitalized)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("#F1C27B"))
                                            
                                    }
                                }
                            }
                            .padding()
                            .background(Color(.tertiarySystemBackground))
                            .cornerRadius(20)
                            .shadow(radius: 5)
                            .frame(maxWidth:.infinity)
                        }
                    }
                    .padding()
                }
            }
        }
        .padding()
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }

}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentWrapper {
            StatusView()
        }
    }
}
