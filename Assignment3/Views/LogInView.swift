//
//  LogIn.swift
//  Assignment3
//
//  Created by quy.nguyn on 08/09/2023.
//

import SwiftUI

struct LogInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoggedIn = false
    
    
    var body: some View {
        NavigationView{
            VStack {
                Image("icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.top, 20)
                Text("Welcome \nto Gourmet")
                    .font(.system(size: 50,weight: .bold,design: .default))
                    .foregroundColor(Color(hex: 0xf1c27b))
                    .padding(.bottom, 20)
                
                Text("Sign into your account")
                    .font(.system(size: 15,weight: .bold,design: .default))
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)
                
                VStack(spacing: 20) {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(Color(hex: 0xf1c27b))
                            .frame(width: 30, height: 30)
                        
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(10)
                        
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color(hex: 0x85a389), lineWidth: 3))
                    
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color(hex: 0xf1c27b))
                            .frame(width: 35, height: 35)
                        
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(10)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color(hex: 0x85a389), lineWidth: 3))
                }
                
                if isLoggedIn {
                    
                    NavigationLink(
                        destination: HomeView(isLoggedIn: $isLoggedIn),
                        isActive: $isLoggedIn,
                        label: { EmptyView() }
                    )
                    .hidden()
                }
                
                HStack {
                    Image(systemName: "door.right.hand.open")
                    Button("Log In") {
                        // Implement your login logic here
                        if email.isEmpty || password.isEmpty {
                            showAlert = true
                            alertMessage = "Please enter your email and password."
                        } else {
                            // Perform login action (e.g., using Firebase)
                            // If successful, navigate to the main app screen
                            // If failed, show an error message
                            isLoggedIn = true
                        }
                    }
                    
                }
                .font(.title)
                .foregroundColor(.white)
                .padding(.vertical, 10) // Adjust vertical padding as needed
                .padding(.horizontal, 20)
                .background(Color(hex: 0x85a389))
                .cornerRadius(10)
                Spacer()
                
                HStack {
                    Text("Don't have an Account?")
                        .foregroundColor(.gray)
                    
                    NavigationLink(destination: SignUpView(isLoggedIn: $isLoggedIn)) {
                        Text("Create")
                            .bold()
                            .foregroundColor(Color(hex: 0x85a389))
                    }
                }
                .padding()
                
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        
    }
    
    
}


struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
