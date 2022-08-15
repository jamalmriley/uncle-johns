//
//  CartButton.swift
//  Uncle John's
//
//  Created by Jamal Riley on 8/7/22.
//

import SwiftUI

struct CartButton: View {
    @EnvironmentObject var restaurantModel: RestaurantModel
    var numOfMenuItems: Int
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(systemName: "bag")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 27, height: 27)
            
            if numOfMenuItems > 0 {
                Text("\(numOfMenuItems)")
                    .font(.custom("AvenirNext-Medium", size: 13))
                    .padding(.bottom, 1)
            }
        }
        .foregroundColor(Color("ForegroundColor \(restaurantModel.selectedRestaurant == 0 ? "(DD)" : "(UJB)")"))
    }
}

struct CartButton_Previews: PreviewProvider {
    static var previews: some View {
        CartButton(numOfMenuItems: 1)
            .environmentObject(RestaurantModel())
    }
}

