//
//  CartModel.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/7/22.
//

import Foundation

class CartModel: ObservableObject {
    @Published private(set) var menuItems: [MenuItem] = []
    @Published private(set) var total: Double = 0
    
    func addToCart(menuItem: MenuItem) {
        menuItems.append(menuItem)
        total += menuItem.price
    }
    
    func removeFromCart(menuItem: MenuItem) {
        menuItems = menuItems.filter { $0.id != menuItem.id }
        total -= menuItem.price
    }
}
