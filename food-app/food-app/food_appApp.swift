//
//  food_appApp.swift
//  food-app
//
//  Created by Tekup-mac-2 on 27/11/2024.
//

import SwiftUI
import Firebase
@main
struct food_appApp: App {
    
    init() {
            FirebaseApp.configure()
        }
    var body: some Scene {
        WindowGroup {
            SignInView()
        }
    }
}
