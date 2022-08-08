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
    var colorSchemeSuffix = ["(DD)", "(UJB)"]
    var menuItem: MenuItem
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottomLeading) {
                Image(menuItem.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 160, height: 240)
                    .cornerRadius(20)
                    .scaledToFit()
                
                // MARK: - Menu Item Name and Price
                VStack(alignment: .leading) {
                    Text(menuItem.name)
                        .font(.custom("AvenirNext-Bold", size: 16))
                    
                    Text("$\(String(format: "%.2f", menuItem.price))")
                        .font(.custom("AvenirNext-Medium", size: 16))
                }
                .padding()
                .frame(width: 160, height: 70, alignment: .leading)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
            }
            .frame(width: 160, height: 240)
            .shadow(radius: 3)
            
            Button {
                cartModel.addToCart(menuItem: menuItem)
                print("Added to cart")
            } label: {
                Image(systemName: "plus")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(50)
                    .padding([.top, .trailing])
            }
        }
    }
}

struct MenuItemCard_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemCard(menuItem: menuList[0])
            .environmentObject(CartModel())
            .environmentObject(RestaurantModel())
            .colorScheme(.dark)
    }
}
