//
//  DatDonutMenu.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/4/22.
//

import Foundation

class FoodItem: Decodable, Identifiable, ObservableObject, Equatable {
    
    static func ==(lhs: FoodItem, rhs: FoodItem) -> Bool {
        return lhs.id == rhs.id &&
        lhs.quantity == rhs.quantity &&
        lhs.name == rhs.name &&
        lhs.addOn == rhs.addOn &&
        lhs.price == rhs.price &&
        lhs.unitPrice == rhs.unitPrice &&
        lhs.menuCategory == rhs.menuCategory &&
        lhs.itemCategory == rhs.itemCategory
    }
    
    var id: UUID?
    var quantity: Int
    var name: String
    var addOn: String
    var price: Float
    var unitPrice: Float?
    var menuCategory: String
    var itemCategory: String
}

class BeverageItem: Decodable, Identifiable, ObservableObject, Equatable {
    
    static func ==(lhs: BeverageItem, rhs: BeverageItem) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.small == rhs.small &&
        lhs.medium == rhs.medium &&
        lhs.large == rhs.large &&
        lhs.oneSize == rhs.oneSize &&
        lhs.menuCategory == rhs.menuCategory &&
        lhs.itemCategory == rhs.itemCategory
    }
    
    var id: UUID?
    var name: String
    var small: Float?
    var medium: Float?
    var large: Float?
    var oneSize: Float?
    var menuCategory: String
    var itemCategory: String
}
