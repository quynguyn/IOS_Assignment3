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
                Text("").padding(.leading, 220)
                Toggle("Dark Mode", isOn: $isDarkMode).padding(.trailing, 20)
            }
            
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .padding(.top, 15)
            
//            Text("Welcome, \(authStore.user?.displayName ?? "user")").foregroundColor(isDarkMode ?.white :.black)
//                .background(isDarkMode ?.black :.white)
            
            VStack (spacing: 20){
                CustomTextField(placeholder: "\(authStore.user?.displayName ?? "user")", iconName: "person.fill", text: $name)
                CustomTextField(placeholder: "\(authStore.user?.phone ?? "user")", iconName: "phone.fill", text: $phone)
                    .keyboardType(.phonePad)
                CustomTextField(placeholder: "\(authStore.user?.email ?? "user")", iconName: "envelope.fill", text: $email)
                    .disabled(true)
                    .foregroundColor(.gray)
                CustomTextField(placeholder: "\(authStore.user?.address ?? "user")", iconName: "house.fill", text: $address)
                
                Spacer()
                
                HStack{
                    HStack{
                        Image(systemName: "square.and.arrow.down")
                            .font(.system(size: 25,weight: .bold))
                            .foregroundColor(Color.white)
                        
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
                                .font(.system(size: 25,weight: .bold))
                                .foregroundColor(Color.white)
                                .padding()
                        }
                    }.frame(maxWidth: .infinity)
                        .background(Color(hex: 0xa2cdb0))
                        .cornerRadius(15)
                
                
                HStack{
                    
                    Image(systemName: "door.left.hand.open")
                        .font(.system(size: 25,weight: .bold))
                        .foregroundColor(Color.white)
                    
                    Button(action: {
                        AuthService.signOut();
                    })  {
                        Text("Log Out")
                            .font(.system(size: 25,weight: .bold))
                            .foregroundColor(Color.white)
                            .padding()
                        
                    }
                }.frame(maxWidth: .infinity)
                    .background(Color(hex: 0xa2cdb0))
                    .cornerRadius(15)
            }
        
                
                
            }
            .padding()
            .preferredColorScheme(isDarkMode ?.dark :.light )
            
            
            
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
