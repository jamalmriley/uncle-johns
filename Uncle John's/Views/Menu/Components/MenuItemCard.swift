//
//  MenuItemCard.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/7/22.
//

import SwiftUI

struct MenuItemCard: View {
    @EnvironmentObject var cartModel: CartModel
    @EnvironmentObject var restaurantModel: RestaurantModel
    var menuItem: MenuItem
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottomLeading) {
                Image(menuItem.image)
                    .resizable()
                    .frame(width: 150, height: 225)
                    .cornerRadius(20)
                
                // MARK: - Menu Item Name and Price
                VStack(alignment: .leading) {
                    Text(menuItem.name)
                        .font(.custom("AvenirNext-Bold", size: 16))
                    
                    Text("$\(String(format: "%.2f", menuItem.price)) | 123 cal")
                        .font(.custom("AvenirNext-Medium", size: 14))
                }
                .padding()
                .frame(width: 150, height: 70, alignment: .leading)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
            }
            .shadow(radius: 3)
            
            Button {
                withAnimation(.spring()) {
                    print(menuItem.itemID)
                    restaurantModel.currentMenuItemID = menuItem.itemID
                    restaurantModel.currentMenuItemName = menuItem.name
                    restaurantModel.currentMenuItemPrice = menuItem.price
                    restaurantModel.currentMenuItemImage = menuItem.image
                    restaurantModel.currentMenuItemDesc = menuItem.desc
                    restaurantModel.showMenuItemCustomization = true
                    restaurantModel.heights = [CGFloat(menuItem.drawerHeight)]
                }
            } label: {
                ZStack {
                    Capsule()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color("AccentColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                    Image(systemName: "bag.fill.badge.plus")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                }
            }
            .buttonStyle(.plain)
            .padding([.top, .trailing], 10)
        }
        .contextMenu {
            Text(menuItem.name)
            
            Button {
                //
            } label: {
                Label("Add to Order", systemImage: "bag")
            }
            
            Button {
                //
            } label: {
                Label("Nutrition Facts", systemImage: "info.circle")
            }
            
            Button {
                //
            } label: {
                Label("Add to Favorites", systemImage: "star")
            }
        }
        .frame(width: 150, height: 225)
    }
}

struct MenuItemCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                MenuItemRow(menuItem: MenuItem(itemID: 1, name: "Test", image: "BBQ", price: 3.99, desc: "A delicious menu item you have to try!", drawerHeight: 100))
                    .padding()
                MenuItemCard(menuItem: MenuItem(itemID: 1, name: "Test", image: "BBQ", price: 3.99, desc: "A delicious menu item you have to try!", drawerHeight: 100))
            }
            .environmentObject(CartModel())
            .environmentObject(RestaurantModel())
            .colorScheme(.dark)
        }
    }
}
