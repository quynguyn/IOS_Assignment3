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
import GoogleSignIn
import GoogleSignInSwift

struct LogInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isSigningIn = false
    @EnvironmentObject private var authStore : AuthStore
    
    private func handleSuccessLogIn() {
        self.isSigningIn = false
    }
    
    private func handleErrorLogIn(_ error: Error) {
        self.showAlert = true
        self.alertMessage = error.localizedDescription
        
        self.isSigningIn = false
    }
    
    var body: some View {
        LoadingView(isShowing: $isSigningIn, loadingText: "Signing In...") {
            NavigationView {
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
                    //https://stackoverflow.com/questions/62348642/how-to-switch-to-another-view-programmatically-in-swiftui-without-a-button-pres
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
                                self.isSigningIn = true
                                AuthService.signInWithEmailAndPassword(
                                    email: self.email,
                                    password: self.password,
                                    onSuccess: self.handleSuccessLogIn,
                                    onError: self.handleErrorLogIn)
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
                        
                        NavigationLink(destination: SignUpView()) {
                            Text("Create")
                                .bold()
                                .foregroundColor(Color(hex: 0x85a389))
                        }
                    }
                    .padding()
                    
                    GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                        
                        self.isSigningIn = true
                        AuthService.signInWithGoogle(
                            onSuccess: handleSuccessLogIn,
                            onError: handleErrorLogIn
                        )
                    }
                    
                    
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
}


struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentWrapper {
            LogInView()
        }
        
    }
}
