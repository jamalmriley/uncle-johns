//
//  ScanView.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/9/22.
//

import SwiftUI

struct ScanView: View {
    @EnvironmentObject var cartModel: CartModel
    @EnvironmentObject var restaurantModel: RestaurantModel
    
    var body: some View {
        ZStack {
            Color("BackgroundColor \(restaurantModel.selectedRestaurant == 0 ? "(DD)" : "(UJB)")")
                .ignoresSafeArea()
            VStack {
                Header()
                
                Spacer()
                PaymentCards()
                Spacer()
            }
        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
            .environmentObject(CartModel())
            .environmentObject(RestaurantModel())
            .colorScheme(.dark)
    }
}
