//
//  CartView.swift
//  Assignment3
//
//  Created by Vũ Nguyệt Minh on 11/09/2023.
//

import SwiftUI

struct CartView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var authStore: AuthStore
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {
            Text("Cart")
                .font(.system(size: 24, design: .rounded))
                .fontWeight(.bold)
                .padding(.bottom)
                .frame(
                    maxWidth: UIScreen.main.bounds.width + 10
                        //, alignment: .leading
                )
            
            ScrollView {
                VStack {
                    if (cartManager.items.count > 0) {
                        ForEach(cartManager.items, id: \.id) {
                            item in
                            ItemRow(item: item)
                                .padding()
                        }
                    }
                    else {
                        Image("emptycart")
                            .resizable()
                            .frame(width: 200, height: 200, alignment: .center)
                            .padding()
                        Text("Your cart is empty!")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            
            Spacer()
            VStack {
//                LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 1)], startPoint: .top, endPoint: .bottom)
//                       .frame(height: 15)
//                       .opacity(0.8)
                if let user = authStore.user {
                    NavigationLink {
                        CheckoutView(user: authStore.user!)
                    } label: {
                        Text("Check out - $\(cartManager.totalPrice, specifier: "%.2f")")
                            .bold()
                            .font(.system(size: 20))
                            .foregroundColor(Color.white)
                            .frame(width: CGFloat(350), height: CGFloat(65))
                            .background(Color("#A2CDB0"))
                            .cornerRadius(10)
                            .padding()
                    }
                    .disabled(cartManager.items.isEmpty) // Disable the button if cart is empty
                    .opacity(cartManager.items.isEmpty ? 0.5 : 1)
                    .padding()
                }
                
            }
            .frame(maxWidth: .infinity, minHeight: 150, alignment: .bottom)
            .shadow(color: colorScheme == .dark ? Color.gray.opacity(0.2) :
            Color.gray.opacity(0.5), radius: 10,x: 0, y : -5)
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
