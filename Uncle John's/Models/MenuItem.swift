//
//  MenuItem.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/7/22.
//

import Foundation

struct MenuItem: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var price: Double
}

var menuList = [MenuItem(name: "Uncle John's Special", image: "BBQ", price: 5.5),
            MenuItem(name: "Rib Tips", image: "BBQ", price: 8.45),
            MenuItem(name: "Hot Links", image: "BBQ", price: 8.75),
            MenuItem(name: "Rib Tips & Hot Link Combo", image: "BBQ", price: 9.75),
            MenuItem(name: "Chicken Gizzards", image: "BBQ", price: 5.5),
            MenuItem(name: "Jerk Rib Tips", image: "BBQ", price: 9.75)]
