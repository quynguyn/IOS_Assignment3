//
//  HistoryView.swift
//  Assignment3
//
//  Created by Vũ Nguyệt Minh on 11/09/2023.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject private var foodOrderStore : FoodOrderStore
    
    var body: some View {
        ScrollView {
            if foodOrderStore.foodOrders.isEmpty {
                Text("You haven't ordered anything.")
            }
            else {
                ForEach(foodOrderStore.foodOrders, id: \.id) { order in
                    Text(order.orderedAt.ISO8601Format())
                }
            }
            
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentWrapper {
            HistoryView()
        }
    }
}
