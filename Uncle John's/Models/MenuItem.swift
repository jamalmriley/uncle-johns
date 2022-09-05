//
//  MenuItem.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/7/22.
//

import Foundation

struct MenuItem: Identifiable {
    var id = UUID()
    var itemID: Int
    var name: String
    var image: String
    var price: Double
    var desc: String
}

var menuList = [MenuItem(itemID: 0, name: "Uncle John's Special", image: "BBQ", price: 5.5, desc: ""),
                MenuItem(itemID: 1, name: "Rib Tips", image: "BBQ", price: 8.45, desc: ""),
                MenuItem(itemID: 2, name: "Hot Links", image: "BBQ", price: 8.75, desc: ""),
                MenuItem(itemID: 3, name: "Rib Tips & Hot Link Combo", image: "BBQ", price: 9.75, desc: ""),
                MenuItem(itemID: 4, name: "Chicken Gizzards", image: "BBQ", price: 5.5, desc: ""),
                MenuItem(itemID: 5, name: "Jerk Rib Tips", image: "BBQ", price: 9.75, desc: "")]
