//
//  Header.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/10/22.
//

import SwiftUI

struct Header: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    @EnvironmentObject var cartModel: CartModel
    @Environment(\.colorScheme) var colorScheme
    private var emojis = ["🍩", "🍖"]
    
    var body: some View {
        VStack {
            HStack {
                CustomSegmentedControl(selection: $restaurantModel.selectedRestaurant, options: emojis, width: 90, fontSize: 16)
                
                Spacer()
                
                NavigationLink {
                    CartView()
                        .environmentObject(cartModel)
                } label: {
                    CartButton(numOfMenuItems: cartModel.menuItems.count)
                }
                .disabled(cartModel.menuItems.count <= 0)
                
            }
            .overlay {
                Image(restaurantModel.selectedRestaurant == 0 ? "Dat Donut Header" : colorScheme == .light ? "Uncle John's Header (Light)" : "Uncle John's Header (Dark)")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            Divider()
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            Header()
                .environmentObject(AppSettingsModel())
                .environmentObject(CartModel())
                .environmentObject(RestaurantModel())
                .colorScheme(.light)
        }
        
        ZStack {
            Color.black.ignoresSafeArea()
            
            Header()
                .environmentObject(AppSettingsModel())
                .environmentObject(CartModel())
                .environmentObject(RestaurantModel())
                .colorScheme(.dark)
        }
    }
}
