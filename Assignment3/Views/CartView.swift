//
//  CartView.swift
//  Assignment3
//
//  Created by Vũ Nguyệt Minh on 11/09/2023.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var selectedTab: Int = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
//                HStack {
//                    Spacer()
//                    NavigationLink {
//                        HomeView()
//                    } label: {
//                        Image(systemName: "house")
//                            .foregroundColor(Color.white)
//                            .padding(.all)
//                            .background(Color("#A2CDB0"))
//                            .cornerRadius(40)
//                    }
//                    .padding()
//                    .navigationBarBackButtonHidden(true)
//                }
                Spacer()
                VStack {
                    if (cartManager.items.count > 0) {
                        ForEach(cartManager.items, id: \.id) {
                            item in
                            ItemRow(item: item)
                                .padding()
                        }
                    }
                    else {
                        Text("Your cart is empty!")
                    }
                    Spacer()
                    HStack {
                        Text("Your total is:")
                            .padding()
                        //Spacer()
                        Text("$\(cartManager.total, specifier: "%.2f")")
                            .padding()
                            .bold()
                    }
                    //Spacer()
                    NavigationLink {
                        CheckoutView()
                    } label: {
                        Text("Check out")
                            .bold()
                            .font(.system(size: 20))
                            .foregroundColor(Color.white)
                            .frame(width: CGFloat(120), height: CGFloat(65))
                            .background(Color("#F1C27B"))
                            .cornerRadius(30)
                            .padding()
                    }
                }
            }
        }
        .navigationTitle(Text("My Cart"))
        .padding(.top)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}
