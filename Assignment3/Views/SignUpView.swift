//
//  SignUpView.swift
//  Assignment3
//
//  Created by quy.nguyn on 09/09/2023.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var phone = ""
    @State private var name = ""
    @State private var address = ""
    @State private var isFormValid = false
    @State private var isShowingAlert = false
    @State private var navigateToHomeView = false
    
    var body: some View {
        NavigationView{
            VStack {
                Image("icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.top, 20)
                VStack (spacing: 15) {
                    CustomTextField(placeholder: "Email", iconName: "envelope.fill", text: $email)
                        .keyboardType(.emailAddress)
                    CustomSecureField(placeholder: "Password", iconName: "lock.fill", text: $password)
                    CustomTextField(placeholder: "Phone", iconName: "phone.fill", text: $phone)
                        .keyboardType(.phonePad)
                    CustomTextField(placeholder: "Name", iconName: "person.fill", text: $name)
                    CustomTextField(placeholder: "address", iconName: "house.fill", text: $address)
                    
                    NavigationLink(
                        destination: HomeView(),
                        isActive: $navigateToHomeView,
                        label: {
                            EmptyView() // This link will remain hidden until isActive is set to true
                        }
                    )
                    .navigationBarHidden(true)
                    
                    Button(action: {
                        if areAllFieldsFilled() {
                            // All fields are filled, proceed with sign-up
                            signUpManager().signUp(email: email, password: password, phone: phone, name: name)
                            navigateToHomeView = true
                        } else {
                            // Show an error message or alert to inform the user
                            // that all fields must be filled.
                            isShowingAlert = true
                        }
                    })  {
                        Text("Sign Up")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: 0xa2cdb0))
                            .cornerRadius(15)
                    }
                    .padding([.top, .leading, .trailing], 20)
                    .alert(isPresented: $isShowingAlert) {
                        Alert(
                            title: Text("Warning"),
                            message: Text("Please fill in all the required fields."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    Text("Have an account?")
                        .font(.title3)
                        .foregroundColor(.gray)
                    
                }
                
                .padding()
                
                Spacer()
                
                Text("Sign up using one of the following methods")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                HStack{
                    Button("Google"){
                        
                    }
                    Button("Apple"){
                        
                    }
                }
            }
        }
        
    }
    
    private func areAllFieldsFilled() -> Bool {
        // Check if all fields are filled
        return !email.isEmpty && !password.isEmpty && !phone.isEmpty && !name.isEmpty && !address.isEmpty
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
