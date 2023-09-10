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
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .padding(.top, 20)
            VStack {
                CustomTextField(placeholder: "Email", iconName: "envelope.circle.fill", text: $email)
                    .keyboardType(.emailAddress)
                CustomSecureField(placeholder: "Password", iconName: "lock.circle.fill", text: $password)
                CustomTextField(placeholder: "Phone", iconName: "phone.circle.fill", text: $phone)
                    .keyboardType(.phonePad)
                CustomTextField(placeholder: "Name", iconName: "person.circle.fill", text: $name)
                
                Button(action: {
                    signUpManager().signUp(email: email, password: password, phone: phone, name: name)
                })  {
                    Text("Sign Up")
                        .font(.system(size: 25,weight: .bold))
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: 0xa2cdb0))
                        .cornerRadius(15)
                }
                .padding([.top, .leading, .trailing], 20)
                
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


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
