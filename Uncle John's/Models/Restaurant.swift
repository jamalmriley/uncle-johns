//
//  Restaurant.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/4/22.
//

import Foundation

class Restaurant: Decodable, Identifiable, ObservableObject, Equatable {
    
    static func ==(lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.nickname == rhs.nickname &&
        lhs.address1 == rhs.address1 &&
        lhs.address2 == rhs.address2 &&
        lhs.city == rhs.city &&
        lhs.state == rhs.state &&
        lhs.zipCode == rhs.zipCode &&
        lhs.phone == rhs.phone &&
        lhs.email == rhs.email &&
        lhs.latitude == rhs.latitude &&
        lhs.longitude == rhs.longitude // &&
        // lhs.foodItems == rhs.foodItems &&
        // lhs.beverageItems == rhs.beverageItems
    }
    
    var id: UUID?
    var name: String
    var nickname: String
    var address1: String
    var address2: String
    var city: String
    var state: String
    var zipCode: Int
    var phone: Int
    var email: String
    var latitude: Double
    var longitude: Double
    var foodItems: [FoodItem]
    var beverageItems: [BeverageItem]
}

class FoodItem: Decodable {
    var quantity: Int
    var name: String
    var addOn: String
    var price: Float
    var unitPrice: Float?
    var menuCategory: String
    var itemCategory: String
}

class BeverageItem: Decodable {
    var name: String
    var small: Float?
    var medium: Float?
    var large: Float?
    var oneSize: Float?
    var menuCategory: String
    var itemCategory: String
}
