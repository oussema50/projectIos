//
//  FoodCartItem.swift
//  food-app
//
//  Created by Tekup-mac-2 on 27/11/2024.
//


import Foundation

// Represent a single item in the cart
struct FoodCartItem: Identifiable {
    var id = UUID()
    var item: FoodItem
    var quantity: Int
}

// Order model to be stored in Firestore
struct Order: Identifiable {
    var id = UUID()
    var userId: String
    var items: [FoodCartItem]  // Use FoodCartItem instead of CartItem
    var totalPrice: Double
    var orderDate: Date
}
