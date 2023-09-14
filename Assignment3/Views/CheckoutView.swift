//
//  CheckoutView.swift
//  Assignment3
//
//  Created by Duy Anh Pham on 10/09/2023.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var cartManager: CartManager
    var body: some View {
        NavigationView() {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    // MARK: - Address section
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "map.fill")
                                .font(.system(size: 20, design: .rounded))
                                .foregroundColor(Color("#F1C27B"))
                            
                            Text("Address")
                                .font(.system(size: 24, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(Color("#F1C27B"))
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
                                .foregroundColor(Color("#F1C27B"))
                            
                            Text("Your Order")
                                .font(.system(size: 24, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(Color("#F1C27B"))
                        }
    
                        ForEach(cartManager.items, id: \.id) { item in
                            YourOrderView(item: item)
                        }
                    }
                    
                    // MARK: - Your Order section
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "doc.plaintext")
                                .font(.system(size: 20, design: .rounded))
                                .foregroundColor(Color("#F1C27B"))
                            
                            Text("Payment Detail")
                                .font(.system(size: 24, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(Color("#F1C27B"))
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
                .background(Color("#F1C27B"))
                .cornerRadius(20)
                .shadow(radius: 5)
                .navigationBarTitle("Checkout", displayMode: .inline)
            }
        }
    }
}

struct YourOrderView: View {
    let item: Food
    @State private var foodImage: UIImage? = nil
    var body: some View {
        HStack {
            if let uiImage = foodImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(1, contentMode: .fill)
                    .cornerRadius(20)
            } else {
                Rectangle()  // Placeholder till image loads
                .foregroundColor(.gray)
                .frame(width: 100, height: 100)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(item.name)
                    .lineLimit(1)
                
                HStack {
                    Image(systemName: "dollarsign")
                        .foregroundColor(Color("#E25E3E"))
                    
                    Text("\(item.price, specifier: "%.2f")")
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
        .onAppear {
            loadImageFromURL(urlString: item.image) { image in
                self.foodImage = image
            }
        }
    }
    
    func loadImageFromURL(urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let url = URL(string: urlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    completion(nil)
                }
            }
        }
    }
}

struct PaymentDetailView: View {
    @EnvironmentObject var cartManager: CartManager
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Total payment")
                    .font(.system(size: 24, design: .rounded))
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("\(cartManager.totalPrice, specifier: "%.2f")")
                    .font(.system(size: 20, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color("#F1C27B"))
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
            .environmentObject(CartManager())
    }
}
