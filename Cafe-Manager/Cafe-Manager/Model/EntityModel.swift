//
//  EntityModel.swift
//  Cafe-Manager
//
//  Created by Lionel Rajapakse on 2021-04-16.
//

import Foundation

struct User{
    var userName: String
    var userEmail: String
    var userPassword: String
    var userPhone: String
}

struct FoodItem {
    var _id: String
    var foodName: String
    var foodDescription: String
    var foodPrice: Double
    var discount: Int
}
