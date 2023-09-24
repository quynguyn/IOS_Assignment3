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
import MapKit

struct AddressView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var authStore: AuthStore
    
    @StateObject private var mapStore = MapStore()
    
    @State private var deliveryAddress: String = ""
    @State private var contactName: String = ""
    @State private var contactPhone: String = ""
    @State private var addressType: AddressType = .home
    
    @Binding var address : Address
    
    init(address: Binding<Address>) {
        self._address = Binding(projectedValue: address)
        
        self._contactName = State(initialValue: _address.contactName.wrappedValue ?? "")
        self._contactPhone = State(initialValue: _address.contactPhone.wrappedValue ?? "")
        self._deliveryAddress = State(initialValue: _address.deliveryAddress.wrappedValue ?? "")
        
    }
    
    private func saveAddress() {
        address.deliveryAddress = self.deliveryAddress
        address.contactName = self.contactName
        address.contactPhone = self.contactPhone
        print("save address \(address)")
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack {
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
                            EditableText(placeholder: "Name", text: $contactName)
                        }
                        .padding()
                        .background(Color(.tertiarySystemBackground))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .frame(maxWidth:.infinity)
                        
                        HStack {
                            EditableText(placeholder: "Phone", text: $contactPhone)
                        }
                        .padding()
                        .background(Color(.tertiarySystemBackground))
                        .cornerRadius(10)
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
                            EditableText(placeholder: "Delivery Address", text: $deliveryAddress)
                        }
                        .padding()
                        .background(Color(.tertiarySystemBackground))
                        .cornerRadius(10)
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
                            .cornerRadius(10)
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
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                    
                    MapView(mapStore: mapStore)
                        .frame(height: 250)
                    
                }
                .padding()
                
                Button(action: saveAddress) {
                    Text("Save")
                        .font(.system(size: 25, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                }
                .frame(width: 360)
                .background(Color(hex: 0xa2cdb0))
                .cornerRadius(10)
                .shadow(radius: 5)
                .navigationBarTitle("Address", displayMode: .inline)
                .onChange(of: deliveryAddress) { address in
                    mapStore.getPlace(from: address)
                }
            }
        }.onAppear {
            self.deliveryAddress = address.deliveryAddress ?? ""
            self.contactName = address.contactName ?? ""
            self.contactPhone = address.contactPhone ?? ""
            
            if !self.deliveryAddress.isEmpty {
                mapStore.getPlace(from: self.deliveryAddress)
            }
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentWrapper {
            AddressView(address: .constant(Address(
                deliveryAddress: "702 Nguyen Van Linh, Tan Quy, District 7",
                contactName: "John Doe",
                contactPhone: "123456"
            )))
        }
    }
}
