//
//  SplashScreenView.swift
//  food-app
//
//  Created by Tekup-mac-2 on 27/11/2024.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        VStack {
            if isActive {
                // Main content goes here (e.g., HomeView or any main screen)
                SignInView()
            } else {
                // Lottie splash screen
                LottieView(animationURL: "https://lottie.host/2efe2d77-7973-4d8d-b971-43f7e8663515/tUmSW40pqu.json", loopMode: .loop)
                    .frame(width: .infinity, height: .infinity)
            }
        }.background(Color(red: 0.7, green: 0.9, blue: 0.7)) 
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                withAnimation {
                    isActive = true
                    
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}

