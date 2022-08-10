//
//  CartView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/7/22.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartModel: CartModel
    
    var body: some View {
        ScrollView {
            if cartModel.menuItems.count > 0 {
                ForEach(cartModel.menuItems, id: \.id) { menuItem in
                    MenuItemRow(menuItem: menuItem)
                }
                
                HStack {
                    Text("Subtotal:")
                    Spacer()
                    Text("$\(String(format: "%.2f", cartModel.total))")
                        .bold()
                }
                .padding()
                
            } else {
                Text("Your bag is empty")
            }
        }
        .navigationTitle("My Order")
        .padding(.top)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartModel())
    }
}
