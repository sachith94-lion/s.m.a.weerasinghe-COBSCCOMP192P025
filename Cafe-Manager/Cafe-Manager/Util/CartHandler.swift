//
//  CartHandler.swift
//  Cafe-Manager
//
//  Created by Lionel Rajapakse on 2021-04-28.
//

import Foundation

class CartHandler {
    
    static var foodItems: [FoodItem] = []
    
    static func getCartItems() -> [FoodItem] {
        return foodItems
    }
    
    static func clearCart() {
        self.foodItems.removeAll()
    }
}
