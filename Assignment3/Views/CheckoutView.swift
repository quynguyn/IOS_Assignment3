//
//  CheckoutView.swift
//  Assignment3
//
//  Created by Duy Anh Pham on 10/09/2023.
//

import SwiftUI

struct CheckoutView: View {
    var body: some View {
        NavigationView() {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    // MARK: - Address section
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "map.fill")
                                .font(.system(size: 20, design: .rounded))
                                .foregroundColor(Color("#A2CDB0"))
                            
                            Text("Address")
                                .font(.system(size: 24, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(Color("#A2CDB0"))
                        }
                        
                        NavigationLink(destination: AddressView()) {
                            HStack(spacing: 10) {
                                Text("702 Nguyen Van Linh, Tan Quy, District 7")
                                    .foregroundColor(.black)
                                    .lineLimit(1)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                        }
                        .padding()
                        .background(Color(.tertiarySystemBackground))
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        .frame(maxWidth:.infinity)
                    }
                    
                    // MARK: - Your Order section
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "fork.knife")
                                .font(.system(size: 20, design: .rounded))
                                .foregroundColor(Color("#A2CDB0"))
                            
                            Text("Your Order")
                                .font(.system(size: 24, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(Color("#A2CDB0"))
                        }
    
                        YourOrderView()
                        YourOrderView()
                    }
                    
                    // MARK: - Your Order section
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "doc.plaintext")
                                .font(.system(size: 20, design: .rounded))
                                .foregroundColor(Color("#A2CDB0"))
                            
                            Text("Payment Detail")
                                .font(.system(size: 24, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(Color("#A2CDB0"))
                        }
    
                        PaymentDetailView()
                    }
                }
                .padding()
                
                Button(action: {
                    
                }) {
                    Text("Place Order")
                        .font(.system(size: 18, design: .rounded))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                }
                .background(Color("#A2CDB0"))
                .cornerRadius(20)
                .shadow(radius: 5)
                .navigationBarTitle("Checkout", displayMode: .inline)
            }
        }
    }
}

struct YourOrderView: View {
    var body: some View {
        HStack {
            Image("image1")
                .resizable()
                .frame(width: 100, height: 100)
                .aspectRatio(1, contentMode: .fill)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Broken Rice with Grilled Pork")
                    .lineLimit(1)
                
                HStack {
                    Text("40,000 VND")
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text("x1")
                        .foregroundColor(.gray)
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

struct PaymentDetailView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Mechandise subtotal")
                Spacer()
                Text("80,000 VND")
            }
            
            HStack {
                Text("Shipping subtotal")
                Spacer()
                Text("0 VND")
            }
            
            HStack {
                Text("Total payment")
                    .font(.system(size: 24, design: .rounded))
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("80,000 VND")
                    .font(.system(size: 20, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color("#E25E3E"))
            }
        }
        .padding()
        .background(Color(.tertiarySystemBackground))
        .cornerRadius(20)
        .shadow(radius: 5)
        .frame(maxWidth:.infinity)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
