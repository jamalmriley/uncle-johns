//
//  TestView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 9/29/22.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    var itemCategory: String
    
    var body: some View {
        let columns = [
            GridItem(.fixed(140)),
            GridItem(.fixed(140))
        ]
        let items = restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0.filter{$0.itemCategory == itemCategory}
        
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(items, id: \.itemID) { item in
                    let quantityHeader: String = item.quantity > 0 ? "(\(item.quantity)) " : ""
                    let menuItemName: String = quantityHeader + item.name
                    let menuItemPrice: Double = Double(item.singleSizePrice)
                    MenuItemCard(menuItem: MenuItem(itemID: item.itemID, name: menuItemName, image: "BBQ", price: menuItemPrice, desc: item.description))
//                        .frame(width: 140, height: 210)
                        .border(.red, width: 4)
                }
            }
            .padding(.horizontal)
        }
        
        /* Grid {
         let items = restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0.filter{$0.itemCategory == itemCategory}
         let count = Double(items.count)
         let arr = [1, 0]
         
         ForEach(0..<Int(ceil(count/2)), id: \.self) { i in
         GridRow {
         ForEach(arr, id: \.self) { el in
         let index = 2 * (i + 1) - el
         let item = items[index]
         let quantityHeader: String = item.quantity > 0 ? "(\(item.quantity)) " : ""
         let menuItemName: String = quantityHeader + item.name
         let menuItemPrice: Double = Double(item.singleSizePrice)
         
         if index <= Int(count) {
         //                                    VStack {
         //                                        MenuItemCard(menuItem: MenuItem(itemID: 1, name: "Test", image: "BBQ", price: 3.99, desc: "A delicious menu item you have to try!"))
         //                                        Text("\(index)")
         //                                    }
         MenuItemCard(menuItem: MenuItem(itemID: item.itemID, name: menuItemName, image: "BBQ", price: menuItemPrice, desc: item.description))
         //                                        .padding(5)
         }
         }
         }
         }
         } */
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(itemCategory: "Our Donuts")
            .environmentObject(RestaurantModel())
    }
}
