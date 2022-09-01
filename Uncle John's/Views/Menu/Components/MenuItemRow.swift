//
//  MenuItemRow.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/7/22.
//

import SwiftUI

struct MenuItemRow: View {
    @EnvironmentObject var cartModel: CartModel
    var menuItem: MenuItem
    
    var body: some View {
        HStack(spacing: 20) {
            Image(menuItem.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .cornerRadius(25)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(menuItem.name)
                    .font(.custom("AvenirNext-DemiBold", size: 16))
                
                Text("$\(String(format: "%.2f", menuItem.price))")
                    .font(.custom("AvenirNext-Regular", size: 16))
            }
            
            Spacer()
            
            Image(systemName: "trash")
                .foregroundColor(.red)
                .onTapGesture {
                    cartModel.removeFromCart(menuItem: menuItem)
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MenuItemRow_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemRow(menuItem: menuList[0])
            .environmentObject(CartModel())
    }
}
