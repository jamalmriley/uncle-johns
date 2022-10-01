//
//  MenuItemRow.swift
//  Uncle John's
//
//  Created by Jamal Riley on 9/4/22.
//

import SwiftUI

struct MenuItemRow: View {
    @EnvironmentObject var cartModel: CartModel
    @EnvironmentObject var restaurantModel: RestaurantModel
    var menuItem: MenuItem
    
    var body: some View {
        VStack {
            
            ZStack {
                Rectangle()
                    .frame(width: 350, height: 75)
                    .background(.ultraThinMaterial)
                
                HStack {
                    Image(menuItem.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 75, height: 75)
                        .cornerRadius(0)
                        .scaledToFit()
                    
                    // MARK: - Menu Item Name and Price
                    VStack(alignment: .leading) {
                        Text(menuItem.name)
                            .font(.custom("AvenirNext-Bold", size: 16))
                        
                        Text("$\(String(format: "%.2f", menuItem.price)) | 123 cal")
                            .font(.custom("AvenirNext-Medium", size: 16))
                    }
                    .padding(.leading, 5)
                    
                    Spacer()
                    
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
                                .frame(width: 50, height: 30)
                                .foregroundColor(Color("AccentColor \(Color.suffixArray[restaurantModel.selectedRestaurant])"))
                            Image(systemName: "bag.fill.badge.plus")
                                .renderingMode(.template)
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(.plain)
                    .padding(.trailing)
                }
            }
            .cornerRadius(15)
            .frame(width: 350, height: 75)
            .contextMenu {
                Text(menuItem.name)
                
                Button {
                    withAnimation(.spring()) {
                        restaurantModel.currentMenuItemID = menuItem.itemID
                        restaurantModel.currentMenuItemName = menuItem.name
                        restaurantModel.currentMenuItemPrice = menuItem.price
                        restaurantModel.currentMenuItemImage = menuItem.image
                        restaurantModel.showMenuItemCustomization = true
                    }
                } label: {
                    Label("Add to Order", systemImage: "bag.badge.plus")
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
        }
    }
}

struct MenuItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            MenuItemRow(menuItem: MenuItem(itemID: 0, name: "Test", image: "BBQ", price: 99.99, desc: "", drawerHeight: 100))
                .environmentObject(CartModel())
                .environmentObject(RestaurantModel())
                .colorScheme(.dark)
        }
    }
}
