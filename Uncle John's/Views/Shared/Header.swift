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
                /* NavigationLink {
                    SettingsView()
                        .navigationBarTitleDisplayMode(.inline)
                        .environmentObject(settings)
                } label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color("ForegroundColor \(restaurantModel.selectedRestaurant == 0 ? "(DD)" : "(UJB)")"))
                } */
                Picker("Picker", selection: $restaurantModel.selectedRestaurant) {
                    ForEach(0..<restaurantModel.restaurants.count, id: \.self) { index in
                        Text(emojis[index])
                            .tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 80)
                
                Spacer()
                
                NavigationLink {
                    CartView()
                        .environmentObject(cartModel)
                } label: {
                    CartButton(numOfMenuItems: cartModel.menuItems.count)
                }
                
            }
            .overlay {
                Image(restaurantModel.selectedRestaurant == 0 ? "Dat Donut Header" : colorScheme == .light ? "Uncle John's Header (Light)" : "Uncle John's Header (Dark)")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
            }
            .padding()
            Divider()
        }
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
            .environmentObject(AppSettingsModel())
            .environmentObject(CartModel())
            .environmentObject(RestaurantModel())
            .colorScheme(.light)
    }
}
