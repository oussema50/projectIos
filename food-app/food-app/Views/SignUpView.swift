//
//  SignUpView.swift
//  food-app
//
//  Created by Tekup-mac-2 on 27/11/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showSignIn = false
    @State private var showSuccessDialog = false
    @State private var showErrorDialog = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()
                
                // Title
                Text("Create Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.green)
                
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
                
                // Confirm Password TextField
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                // Sign Up Button
                Button(action: {
                    signUp()
                }) {
                    Text("Sign Up")
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
                
                // Navigation to Sign-In
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                    NavigationLink("Sign In", destination: SignInView())
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
            // Success Dialog with Yes/No options
            .alert("Account Created", isPresented: $showSuccessDialog, actions: {
                Button("Yes") {
                    showSignIn = true // Navigate to Sign-In screen
                }
                Button("No", role: .cancel) { }
            }, message: {
                Text("Your account has been created successfully. Would you like to go to the Sign In page?")
            })
            // Error Dialog
            .alert("Error", isPresented: $showErrorDialog, actions: {
                Button("OK", role: .cancel) { }
            }, message: {
                Text(errorMessage)
            })
            // Navigate to Sign-In on Success
            .navigationDestination(isPresented: $showSignIn) {
                SignInView()
            }
        }
    }

    // Firebase Sign-Up Function
    private func signUp() {
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            showErrorDialog = true
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
                showErrorDialog = true
            } else {
                // Account created successfully, show success dialog
                showSuccessDialog = true
            }
        }
    }
}




#Preview {
    SignUpView()
}
