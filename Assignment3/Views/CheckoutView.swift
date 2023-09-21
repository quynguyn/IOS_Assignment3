//
//  CheckoutView.swift
//  Assignment3
//
//  Created by Duy Anh Pham on 10/09/2023.
//

import SwiftUI
import Firebase
import SimpleToast

struct CheckoutView: View {
    @EnvironmentObject private var cartManager: CartManager
    @EnvironmentObject private var authStore : AuthStore
    @State private var showToast = false
    
    @State private var showErrorToast = false
    @State private var errorMessage = ""
    
    @State private var address: Address
    
    @State private var isPlacingOrder = false
    
    @State private var navigationTrigger: UUID? = nil
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mainFlowController: MainFlowController
    
    var user : AppUser
    
    init(user: AppUser) {
        self.user = user
        
        _address = State(initialValue: Address(
            deliveryAddress: user.address,
            contactName: user.displayName,
            contactPhone: user.phone
        ))
    }
    
    private let toastOpstions = SimpleToastOptions(
        alignment: .top,
        hideAfter: 1,
        animation: .default,
        modifierType: .slide,
        dismissOnTap: true
    )
    
    var body: some View {
        LoadingView(isShowing: $isPlacingOrder) {
            VStack {
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
                        
                        NavigationLink(destination: AddressView(
                            address: $address
                        )) {
                            HStack(spacing: 10) {
                                Text($address.deliveryAddress.wrappedValue ?? "")
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
                        
                        ScrollView(.vertical) {
                            VStack(spacing: 10) {
                                ForEach(cartManager.items, id: \.id) { item in
                                    YourOrderView(item: item)
                                }
                            }
                            .padding()
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
                    AuthService.bioAuthenticate(
                        onSuccess: placeOrder,
                        onError: {err in
                            self.showErrorToast = true
                            self.errorMessage = err.localizedDescription
                        }
                    )
                }) {
                    Text("Place Order")
                        .font(.system(size: 18, design: .rounded))
                        .fontWeight(.medium)
                    
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                }
                .background(Color(hex: 0xa2cdb0))
                .cornerRadius(20)
                .shadow(radius: 5)
                
                NavigationLink(destination: StatusView(), tag: UUID(), selection: $navigationTrigger) {
                    EmptyView()
                }

            }
            .navigationBarTitle("Checkout", displayMode: .inline)
            .simpleToast(isPresented: $showErrorToast, options: ERROR_TOAST_OPTIONS) {
                HStack {
                    Label(self.errorMessage, systemImage: "x.circle")
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
            }
            .simpleToast(isPresented: $showToast, options: toastOpstions){
                HStack{
                    Image(systemName: "checkmark.seal.fill")
                    Text("Order placed successfully !").bold()
                }
                .padding(20)
                .background(Color(hex: 0xf1c27b))
                .foregroundColor(Color.white)
                .cornerRadius(15)
            }
        }
    }
}

extension CheckoutView {
    func placeOrder() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Error: User is not logged in!")
            return
        }
        
        let foodIds = cartManager.items.map { $0.id }
        
        let orderToCreate = CreateFoodOrder(
            userId: userId,
            foodIdList: foodIds,
            status: .pending,
            orderedAt: Date(),
            deliveryAddress: self.address.deliveryAddress ?? "",
            contactName: self.address.contactName ?? "",
            contactPhone: self.address.contactPhone ?? ""
        )
        
        isPlacingOrder = true
        
        FoodOrderService.create(orderToCreate, onSuccess: {
            print("Order placed successfully!")
            isPlacingOrder = false
            showToast = true
            cartManager.emptyCart()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                mainFlowController.selectedTab = 2
                presentationMode.wrappedValue.dismiss()
            }
        }, onError: { error in
            isPlacingOrder = false
            print("Error placing order: \(error.localizedDescription)")
        })
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
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .lineLimit(1)
                
                Text("$ \(item.price, specifier: "%.2f")")
                    .font(.title3)
                    .foregroundColor(.black)
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
        CheckoutView(user: AppUser(uid: "1", email: "johndoe@email.com", displayName: "John Doe", address: "23B Baker Street", phone: "911"))
            .environmentObject(CartManager())
    }
}
