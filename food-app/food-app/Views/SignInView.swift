//
//  SignInView.swift
//  food-app
//
//  Created by Tekup-mac-2 on 27/11/2024.
//


import SwiftUI
import Firebase
import FirebaseAuth

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showHomeScreen = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()
                
                // Logo
                Image(systemName: "person.circle.fill") // Replace with your logo image
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.green)
                    .padding(.bottom, 30)
                
                // Title
                Text("Welcome Back!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.green)
                
                Text("Sign in to your account")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                // Email TextField
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                // Password TextField
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                // Forgot Password Button
                HStack {
                    Spacer()
                    Button("Forgot Password?") {
                        // Handle forgot password action
                    }
                    .foregroundColor(.green)
                }
                .padding(.bottom, 20)
                
                // Error message display
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                
                // Sign-In Button
                Button(action: {
                    signIn()
                }) {
                    Text("Sign In")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.green, Color.mint]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Navigation to Sign-Up
                HStack {
                    Text("Don’t have an account?")
                        .foregroundColor(.gray)
                    NavigationLink("Sign Up", destination: SignUpView())
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                }
                .padding(.bottom, 30)
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.white, Color(.systemGray5)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
            .fullScreenCover(isPresented: $showHomeScreen) {
                ContentView()
            }
        }
    }
    
    // Firebase Sign In Function
    private func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                // Sign-in successful, navigate to the Home screen
                showHomeScreen = true
            }
        }
    }
}



#Preview {
    SignInView()
}
