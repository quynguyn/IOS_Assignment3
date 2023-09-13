//
//  AddressView.swift
//  Assignment3
//
//  Created by Duy Anh Pham on 10/09/2023.
//

import SwiftUI
import MapKit

struct AddressView: View {
    @State private var address: String = "702 Nguyen Van Linh, Tan Quy, District 7"
    @State private var customerName: String = "Dustin"
    @State private var phoneNumber: String = "012345678"
    @State private var isHomeButtonPressed = false
    @State private var isWorkButtonPressed = false
    
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
                                isHomeButtonPressed.toggle()
                                isWorkButtonPressed = false
                            }) {
                                Image(systemName: isHomeButtonPressed ? "house.fill" : "house")
                                    .foregroundColor(isHomeButtonPressed ? Color("#F1C27B") : .gray)
                                    .font(.title)
                                    .padding()
                            }
                            .background(Color(.tertiarySystemBackground))
                            .cornerRadius(20)
                            .shadow(radius: 5)
                            
                            // Button Work
                            Button(action: {
                                isWorkButtonPressed.toggle()
                                isHomeButtonPressed = false
                            }) {
                                Image(systemName: isWorkButtonPressed ? "briefcase.fill" : "briefcase")
                                    .foregroundColor(isWorkButtonPressed ? Color("#F1C27B") : .gray)
                                    .font(.title)
                                    .padding()
                            }
                            .background(Color(.tertiarySystemBackground))
                            .cornerRadius(20)
                            .shadow(radius: 5)
                        }
                    }
                    
                    MapView(coordinate: CLLocationCoordinate2D(latitude: 10.729303, longitude: 106.696129))
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
                .background(Color("#F1C27B"))
                .cornerRadius(20)
                .shadow(radius: 5)
                .navigationBarTitle("Address", displayMode: .inline)
            }
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView()
    }
}
