//
//  CartView.swift
//  Assignment3
//
//  Created by Vũ Nguyệt Minh on 11/09/2023.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var authStore: AuthStore
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                VStack {
                    ScrollView {
                        VStack {
                            if (cartManager.items.count > 0) {
                                ForEach(cartManager.items, id: \.id) {
                                    item in
                                    ItemRow(item: item)
                                        .padding()
                                }
                            }
                            else { Text("Your cart is empty!") }
                            
                        }
                    }
                }
            }
            Spacer()
            VStack {
                HStack {
                    Text("Your total is:")
                        .padding()
                    Text("$\(cartManager.total, specifier: "%.2f")")
                        .padding()
                        .bold()
                }
                NavigationLink {
                    CheckoutView(user: authStore.user!)
                } label: {
                    Text("Check out")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(Color.white)
                        .frame(width: CGFloat(120), height: CGFloat(65))
                        .background(Color("#A2CDB0"))
                        .cornerRadius(10)
                        .padding()
                }
                .disabled(cartManager.items.isEmpty) // Disable the button if cart is empty
                .opacity(cartManager.items.isEmpty ? 0.5 : 1)
                .padding()
                
            }.frame(maxWidth: .infinity, minHeight: 150, alignment: .bottom)
        }
        .padding(.top)
        
       
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
            CartView()
                .environmentObject(CartManager())
    }
}
