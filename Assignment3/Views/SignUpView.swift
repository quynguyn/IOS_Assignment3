//
//  SignUpView.swift
//  Assignment3
//
//  Created by quy.nguyn on 09/09/2023.
//

import SwiftUI
import SimpleToast

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var phone = ""
    @State private var name = ""
    @State private var address = ""
    @State private var isFormValid = false
    @State private var isShowingAlert = false
    
    
    @State private var showingSignUpErrorToast = false
    @State private var signUpErrorMessage = ""
    @State private var isSigningUp = false
    
    private func handleSuccessSignUp() {
        self.isSigningUp = false
    }
    
    private func handleErrorSignUp(error : Error) {
        self.isSigningUp = false
        self.signUpErrorMessage = error.localizedDescription
        self.showingSignUpErrorToast = true
    }
    
    
    var body: some View {
        LoadingView(isShowing: self.$isSigningUp) {
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
                        
                        Button(action: {
                            if areAllFieldsFilled() {
                                self.isSigningUp = true;
                                // All fields are filled, proceed with sign-up
                                AuthService.createUserWithEmailAndPassword(
                                    email: self.email,
                                    password: self.password,
                                    phone: self.phone,
                                    address: self.address,
                                    name: self.name,
                                    onSuccess: self.handleSuccessSignUp,
                                    onError: self.handleErrorSignUp
                                )
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
                    
                   
                }
            }
            .simpleToast(isPresented: $showingSignUpErrorToast, options: ERROR_TOAST_OPTIONS) {
                HStack {
                    Label(self.signUpErrorMessage, systemImage: "x.circle")
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
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
        EnvironmentWrapper {
            Group{
                SignUpView()
            }
        }
    }
}
