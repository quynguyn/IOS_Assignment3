//
//  profileView.swift
//  Assignment3
//
//  Created by quy.nguyn on 10/09/2023.
//

import SwiftUI

struct ProfileView: View {
    @State private var name = "John Doe"
    @State private var phone = "123-456-7890"
    @State private var email = "johndoe@example.com"
    @State private var address = "123 Main Street, City, Country"
    
    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .padding(.top, 20)
            VStack (spacing: 20){
                CustomTextField(placeholder: "Name", iconName: "person.fill", text: $name)
                CustomTextField(placeholder: "phone", iconName: "phone.fill", text: $phone)
                    .keyboardType(.phonePad)
                CustomTextField(placeholder: "email", iconName: "envelope.fill", text: $email)
                    .disabled(true)
                    .foregroundColor(.gray)
                CustomTextField(placeholder: "address", iconName: "house.fill", text: $address)
                
                Spacer()
                
                HStack{
                    
                    Image(systemName: "door.left.hand.open")
                        .font(.system(size: 25,weight: .bold))
                        .foregroundColor(Color.white)
                    
                    Button(action: {
                        
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
            .padding()
            
            
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}