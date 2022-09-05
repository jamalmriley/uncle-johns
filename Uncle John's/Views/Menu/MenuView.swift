//
//  MenuView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/7/22.
//

import Drawer
import SwiftUI

struct MenuView: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    @EnvironmentObject var cartModel: CartModel
    @State private var selectedSubMenu = 0
    @State private var size = 0
    @State private var animate = true
    @State var heights = [CGFloat(100), CGFloat(150), CGFloat(200), CGFloat(300)]
    private var emojis = ["🍩", "🍖"]
    private var menuCategories = [["Food","Beverages"], ["Lunch & Dinner", "Catering"]]
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Header()
                
                // MARK: - Submenu Selection
                Group {
                    Text("Our Menu")
                        .font(.custom("AvenirNext-Bold", size: 32))
                        .textCase(.uppercase)
                        .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                    
                    CustomSegmentedControl(selection: $selectedSubMenu, options: menuCategories[restaurantModel.selectedRestaurant], width: 350, fontSize: 16)
                }
                
                // MARK: - Menu Item Sections
                VStack {
                    ScrollView (showsIndicators: false) {
                        if restaurantModel.selectedRestaurant == 0 && selectedSubMenu == 0 {
                            Restaurant0Menu0Section(itemCategory: "Our Donuts")
                            Restaurant0Menu0Section(itemCategory: "Our Sandwiches")
                        }
                        else if restaurantModel.selectedRestaurant == 0 && selectedSubMenu == 1 {
                            Restaurant0Menu1Section(itemCategory: "Drinks")
                            Restaurant0Menu1Section(itemCategory: "Juices")
                            Restaurant0Menu1Section(itemCategory: "Fruit Smoothies")
                        }
                        else if restaurantModel.selectedRestaurant == 1 && selectedSubMenu == 0 {
                            Restaurant1Menu0Section(itemCategory: "Lunch Specials")
                            Restaurant1Menu0Section(itemCategory: "Ribs")
                            Restaurant1Menu0Section(itemCategory: "Hot Links")
                            Restaurant1Menu0Section(itemCategory: "Chicken")
                            Restaurant1Menu0Section(itemCategory: "Fish")
                            Restaurant1Menu0Section(itemCategory: "Combos")
                            Restaurant1Menu0Section(itemCategory: "Sides & Extras")
                        }
                        else if restaurantModel.selectedRestaurant == 1 && selectedSubMenu == 1 {
                            Restaurant1Menu1Section(itemCategory: "Rib & Turkey Tips")
                            Restaurant1Menu1Section(itemCategory: "Hot & Turkey Links")
                            Restaurant1Menu1Section(itemCategory: "Chicken")
                            Restaurant1Menu1Section(itemCategory: "Combos")
                            Restaurant1Menu1Section(itemCategory: "Sides & Extras")
                        }
                    }
                }
                .padding(.horizontal)
            }
            .background(Color("BackgroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
            .onTapGesture {
                withAnimation(.spring()) {
                    restaurantModel.showMenuItemCustomization = false
                }
            }
            
            if restaurantModel.showMenuItemCustomization {
                Drawer(heights: $heights) {
                    ZStack(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            
                            // MARK: Menu Item Name and "X" Button
                            HStack {
                                Text("\(restaurantModel.currentMenuItemName)").font(.custom("AvenirNext-Bold", size: 24))
                                Spacer()
                                Button {
                                    withAnimation(.spring()) {
                                        restaurantModel.showMenuItemCustomization = false
                                    }
                                } label: {
                                    Image(systemName: "xmark")
                                        .foregroundColor(Color("ForegroundColor"))
                                }
                            }
                            .padding(.top)
                            
                            if restaurantModel.currentMenuItemDesc != "" {
                                Text(restaurantModel.currentMenuItemDesc)
                                    .font(.custom("AvenirNext-Medium", size: 16))
                                    .lineLimit(2)
                                    .padding(.bottom)
                            }
                            
                            // MARK: Size Selection
                            let sizes = selectedSubMenu == 0 ?
                            restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0[restaurantModel.currentMenuItemID].sizes :
                            restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1[restaurantModel.currentMenuItemID].sizes
                            
                            if sizes.count > 0 {
                                HStack {
                                    Text("Select Size:")
                                        .font(.custom("AvenirNext-Medium", size: 20))
                                    SFSegmentedControl(selection: $size, options: sizes, width: 200)
                                    Spacer()
                                }
                            }
                            
                            
                            Text("Price: ").font(.custom("AvenirNext-Medium", size: 20)) +
                            Text("$\(String(format: "%.2f", restaurantModel.currentMenuItemPrice))").font(.custom("AvenirNext-Bold", size: 20))
                            
                            // MARK: "Add to Order" Button
                            Button {
                                withAnimation(.spring()) {
                                    cartModel.addToCart(menuItem: MenuItem(itemID: restaurantModel.currentMenuItemID, name: restaurantModel.currentMenuItemName, image: restaurantModel.currentMenuItemImage, price: restaurantModel.currentMenuItemPrice, desc: restaurantModel.currentMenuItemDesc))
                                    restaurantModel.showMenuItemCustomization = false
                                }
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .frame(minWidth: 100, maxWidth: 400)
                                        .frame(height: 45)
                                        .frame(maxWidth: .infinity)
                                        .cornerRadius(5)
                                        .foregroundColor(Color("AccentColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                                    
                                    Text("Add to Order")
                                        .foregroundColor(.white)
                                        .font(.custom("AvenirNext-Medium", size: 18))
                                }
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        .background(.thinMaterial)
                    }
                }
                .transition(.move(edge: .bottom))
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(CartModel())
            .environmentObject(RestaurantModel())
            .colorScheme(.dark)
    }
}

struct Restaurant0Menu0Section: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    var itemCategory: String
    
    var body: some View {
        VStack {
            Text(itemCategory)
                .font(.custom("AvenirNext-Bold", size: 24))
                .textCase(.uppercase)
                .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
            
            ForEach(restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0.filter{$0.itemCategory == itemCategory}, id: \.itemID) { item in
                let quantityHeader: String = item.quantity > 0 ? "(\(item.quantity)) " : ""
                let menuItemName: String = quantityHeader + item.name
                let menuItemPrice: Double = Double(item.singleSizePrice)
                
                MenuItemRow(menuItem: MenuItem(itemID: item.itemID, name: menuItemName, image: "BBQ", price: menuItemPrice, desc: item.description))
                    .padding(5)
            }
        }
    }
}
struct Restaurant0Menu1Section: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    var itemCategory: String
    
    var body: some View {
        VStack {
            Text(itemCategory)
                .font(.custom("AvenirNext-Bold", size: 24))
                .textCase(.uppercase)
                .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
            
            ForEach(restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1.filter{$0.itemCategory == itemCategory}, id: \.itemID) { item in
                let quantityHeader: String = item.quantity > 0 ? "(\(item.quantity)) " : ""
                let menuItemName: String = quantityHeader + item.name
                let menuItemPrice: Double = Double(item.singleSizePrice > 0 ? item.singleSizePrice : item.price1)
                
                MenuItemRow(menuItem: MenuItem(itemID: item.itemID, name: menuItemName, image: "BBQ", price: menuItemPrice, desc: item.description))
                    .padding(5)
            }
        }
    }
}
struct Restaurant1Menu0Section: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    var itemCategory: String
    
    var body: some View {
        VStack {
            Text(itemCategory)
                .font(.custom("AvenirNext-Bold", size: 24))
                .textCase(.uppercase)
                .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
            
            ForEach(restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu0.filter{$0.itemCategory == itemCategory}, id: \.itemID) { item in
                let quantityHeader: String = item.quantity > 0 ? "(\(item.quantity)) " : ""
                let menuItemName: String = quantityHeader + item.name
                let menuItemPrice: Double = Double(item.singleSizePrice > 0 ? item.singleSizePrice : item.price1)
                
                MenuItemRow(menuItem: MenuItem(itemID: item.itemID, name: menuItemName, image: "BBQ", price: menuItemPrice, desc: item.description))
                    .padding(5)
            }
        }
    }
}
struct Restaurant1Menu1Section: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    var itemCategory: String
    
    var body: some View {
        VStack {
            Text(itemCategory)
                .font(.custom("AvenirNext-Bold", size: 24))
                .textCase(.uppercase)
                .foregroundColor(Color("ForegroundColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
            
            ForEach(restaurantModel.restaurants[restaurantModel.selectedRestaurant].menu1.filter{$0.itemCategory == itemCategory}, id: \.itemID) { item in
                let quantityHeader: String = item.quantity > 0 ? "(\(item.quantity)) " : ""
                let menuItemName: String = quantityHeader + item.name
                let menuItemPrice: Double = Double(item.singleSizePrice > 0 ? item.singleSizePrice : item.price1)
                
                MenuItemRow(menuItem: MenuItem(itemID: item.itemID, name: menuItemName, image: "BBQ", price: menuItemPrice, desc: item.description))
                    .padding(5)
            }
        }
    }
}
