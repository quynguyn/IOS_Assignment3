//
//  profileView.swift
//  Assignment3
//
//  Created by quy.nguyn on 10/09/2023.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    
    @EnvironmentObject private var authStore : AuthStore

    
    @State private var name = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var address = ""
    
    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .padding(.top, 20)
            Text("Welcome, \(authStore.user?.displayName ?? "user")")
            
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
            
            
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentWrapper {
            Group{
                ProfileView()
            }
        }
    }
}
