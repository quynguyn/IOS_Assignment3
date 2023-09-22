//
//  profileView.swift
//  Assignment3
//
//  Created by quy.nguyn on 10/09/2023.
//

import SwiftUI
import Firebase
import SimpleToast

struct ProfileView: View {
    @State private var isDarkMode = false
    @EnvironmentObject private var authStore : AuthStore
        @State private var showToast = false
    var user: AppUser

    @State private var name = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var address = ""
    
    private let toastOpstions = SimpleToastOptions(
        alignment: .top,
        hideAfter: 0.75,
        backdrop: Color.black.opacity(0.1),
        animation: .default,
        modifierType: .slide,
        dismissOnTap: true
    )
    
    init(user: AppUser) {
        self.user = user
        self._name = State(initialValue: user.displayName ?? "")
        self._phone = State(initialValue: user.phone ?? "")
        self._email = State(initialValue: user.email)
        self._address = State(initialValue: user.address ?? "")
    }
    
    var body: some View {
        VStack {
            HStack() {
                Spacer()
                Button(action: {
                    isDarkMode.toggle()
                }) {
                    Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(isDarkMode ? .white : .black)
                }
                .padding([.top, .trailing])
            }
            
            ScrollView(showsIndicators: false) {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .padding(.top, 15)
                
                VStack (spacing: 16){
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Name")
                            .font(.system(size: 24, design: .rounded))
                            .fontWeight(.medium)
                        
                        CustomTextField(placeholder: "\(authStore.user?.displayName ?? "user")", iconName: "person.fill", text: $name)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Phone")
                            .font(.system(size: 24, design: .rounded))
                            .fontWeight(.medium)
                        
                        CustomTextField(placeholder: "\(authStore.user?.phone ?? "user")", iconName: "phone.fill", text: $phone)
                            .keyboardType(.phonePad)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.system(size: 24, design: .rounded))
                            .fontWeight(.medium)
                        
                        CustomTextField(placeholder: "\(authStore.user?.email ?? "user")", iconName: "envelope.fill", text: $email)
                            .disabled(true)
                        .foregroundColor(.gray)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Address")
                            .font(.system(size: 24, design: .rounded))
                            .fontWeight(.medium)
                        
                        CustomTextField(placeholder: "\(authStore.user?.address ?? "user")", iconName: "house.fill", text: $address)
                    }
                }
                .padding()
                .preferredColorScheme(isDarkMode ?.dark :.light )
            }
            
            HStack {
                Button(action: {
                    if let user = Auth.auth().currentUser {

                        // `user.uid` contains the Firebase Authentication UID of the currently signed-in user.
                        let userId = user.uid

                        // Call your `updateUserProfile` function with the `userId` obtained from Firebase Authentication.
                        AuthService.updateUserProfile(
                            userId: userId,
                            updatedName: name,
                            updatedAddress: address,
                            updatedPhone: phone,
                            onSuccess: {
                                showToast.toggle()
                                print("User profile updated successfully")
                            },
                            onError: { error in
                                print("Error updating user profile: \(error.localizedDescription)")
                            }
                        )
                    } else {
                        // Handle the case where there is no signed-in user.
                        print("No user is currently signed in.")
                    }
                })  {
                    Text("Save")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding()
                }
                .frame(width: 150)
                .background(Color(hex: 0xa2cdb0))
                .cornerRadius(10)
                .shadow(radius: 5)
                
                Spacer().frame(width: 20)
                
                Button(action: {
                    AuthService.signOut();
                })  {
                    Text("Log Out")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding()
                }
                .frame(width: 150)
                .background(Color(hex: 0xa2cdb0))
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .padding()
        }
        .simpleToast(isPresented: $showToast, options: toastOpstions){
            HStack{
                Image(systemName: "square.and.arrow.down.fill")
                Text("Saved").bold()
            }
            .padding(20)
            .background(Color(hex: 0xf1c27b))
            .foregroundColor(Color.white)
            .cornerRadius(15)
        }
    }
}


struct SymbolToggleStyle: ToggleStyle {
 
    var systemImage: String = "checkmark"
    var activeColor: Color = .green
 
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
 
            Spacer()
 
            RoundedRectangle(cornerRadius: 30)
                .fill(configuration.isOn ? activeColor : Color(.systemGray5))
                .overlay {
                    Circle()
                        .fill(.white)
                        .padding(3)
                        .overlay {
                            Image(systemName: systemImage)
                                .foregroundColor(configuration.isOn ? activeColor : Color(.systemGray5))
                        }
                        .offset(x: configuration.isOn ? 10 : -10)
 
                }
                .frame(width: 50, height: 32)
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentWrapper {
            Group{
                ProfileView(user: AppUser.init(uid: "1", email: "john@doe", displayName: "John Doe", address: "A Street", phone: "123123"))
            }
        }
    }
}
