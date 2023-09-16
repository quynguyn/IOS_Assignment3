//
//  AddressView.swift
//  Assignment3
//
//  Created by Duy Anh Pham on 10/09/2023.
//

import SwiftUI
import MapKit

struct AddressView: View {
    @EnvironmentObject private var authStore: AuthStore
    
    @StateObject private var mapStore = MapStore()
    
    @State private var address: String = ""
    @State private var customerName: String = ""
    @State private var phoneNumber: String = ""
    @State private var addressType: AddressType = .home
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    // MARK: - Contact section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "phone.fill")
                                .font(.system(size: 20, design: .rounded))
                                .foregroundColor(Color("#F1C27B"))
                            
                            Text("Contact")
                                .font(.system(size: 24, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(Color("#F1C27B"))
                        }
                        
                        HStack {
                            EditableText(text: $customerName)
                        }
                        .padding()
                        .background(Color(.tertiarySystemBackground))
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        .frame(maxWidth:.infinity)
                        
                        HStack {
                            EditableText(text: $phoneNumber)
                        }
                        .padding()
                        .background(Color(.tertiarySystemBackground))
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        .frame(maxWidth:.infinity)
                    }
                    
                    // MARK: - Delivery address section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "map.fill")
                                .font(.system(size: 20, design: .rounded))
                                .foregroundColor(Color("#F1C27B"))
                            
                            Text("Delivery Address")
                                .font(.system(size: 24, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(Color("#F1C27B"))
                        }
                        
                        HStack {
                            EditableText(text: $address)
                        }
                        .padding()
                        .background(Color(.tertiarySystemBackground))
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        .frame(maxWidth:.infinity)
                        
                        // MARK: - Set address label section
                        HStack(spacing: 16) {
                            // Button Home
                            Button(action: {
                                self.addressType = .home
                            }) {
                                Image(systemName: addressType == .home ? "house.fill" : "house")
                                    .foregroundColor(addressType == .home ? Color("#F1C27B") : .gray)
                                    .font(.title)
                                    .padding()
                            }
                            .background(Color(.tertiarySystemBackground))
                            .cornerRadius(20)
                            .shadow(radius: 5)
                            
                            // Button Work
                            Button(action: {
                                self.addressType = .work
                            }) {
                                Image(systemName: addressType == .work ? "briefcase.fill" : "briefcase")
                                    .foregroundColor(addressType == .work ? Color("#F1C27B") : .gray)
                                    .font(.title)
                                    .padding()
                            }
                            .background(Color(.tertiarySystemBackground))
                            .cornerRadius(20)
                            .shadow(radius: 5)
                        }
                    }
                    
                    MapView(mapStore: mapStore)
                        .frame(height: 250)
                    
                }
                .padding()
                
                Button(action: {
                    
                }) {
                    Text("Save Address")
                        .font(.system(size: 18, design: .rounded))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                }
                .background(Color(hex: 0xa2cdb0))
                .cornerRadius(20)
                .shadow(radius: 5)
                .navigationBarTitle("Address", displayMode: .inline)
                .onChange(of: address) { newAddress in
                    mapStore.getPlace(from: Address(title: newAddress))
                }
            }
        }.onAppear {
            self.address = authStore.user?.address ?? ""
            self.customerName = authStore.user?.displayName ?? ""
            self.phoneNumber = authStore.user?.phone ?? ""
            
            if !self.address.isEmpty {
                mapStore.getPlace(from: Address(title: self.address))
            }
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentWrapper {
            AddressView()
        }
    }
}
