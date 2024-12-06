//
//  MenuItem.swift
//  food-app
//
//  Created by Tekup-mac-2 on 27/11/2024.
//


import Foundation

struct FoodItem: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var price: Double
    var imageURL: String
}
